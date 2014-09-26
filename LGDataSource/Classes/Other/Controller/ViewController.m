//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "ViewController.h"
#import "NewsItem.h"
#import "DataSourceFactory.h"
#import "LGDataSource+PromiseKit.h"


@implementation ViewController
{
    LGDataSource *__n1, *__n2, *__n3, *__n4;
}


#pragma mark - View


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __n1 = [DataSourceFactory newsJSONDataSource];
    __n2 = [DataSourceFactory newsXMLDataSource];
    __n3 = [DataSourceFactory newsJSONDataSource];
    __n4 = [DataSourceFactory newsXMLDataSource];
    
    [__n1 fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
        NSLog(@"__n1");
    
        [__n2 fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
            NSLog(@"__n2");
        }];
    }];
    
    [__n3 objectsFetchPromise].then(^(NSArray *parsedItems) {
        NSLog(@"%@", parsedItems);
        NSLog(@"done __n3");
        return [__n4 objectsFetchPromise];
    }).then(^(NSArray *parsedItems) {
        NSLog(@"%@", parsedItems);
        NSLog(@"done __n4");
    });
    
    [self setupView];
    [self loadTableView];

    [self reloadData];
}


- (void)setupView
{
    self.title = @"News";
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadData)];
    _newsDataSource.activityView = self.view;
}


- (void)loadTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _tableView = tableView;
}


#pragma mark - loadData


- (void)reloadData
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    __weak ViewController *weakSelf = self;

    if (_newsDataSource)
        [_newsDataSource cancelLoad];

    _newsDataSource = [DataSourceFactory newsDataSourceWithActivityView:self.view];

    [_newsDataSource fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
        if (error)
            [weakSelf didFailToGetNewsItemsWithError:error];
        else
            [weakSelf didGetNewItems:parsedItems];
        
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}


- (void)didGetNewItems:(NSArray *)items
{
    _newsItems = items;
    
    [_tableView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


- (void)didFailToGetNewsItemsWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_newsItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cellIdent";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    
    NewsItem *newsItem = [_newsItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = newsItem.newsTitle;
    cell.detailTextLabel.text = newsItem.newsDescription;
    
    return cell;
}


#pragma mark -


@end
