//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LGAbstractXMLParser.h"


@implementation LGAbstractXMLParser
{
	NSMutableString *_mElementValue;
}


#pragma mark - init


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    _dateTimeFormatter = [NSDateFormatter new];
    _dateTimeFormatter.dateFormat = [self dateTimeFormat];
    
    _dateFormatter = [NSDateFormatter new];
    _dateFormatter.dateFormat = [self dateFormat];
}


#pragma mark - LParserInterface


- (void)parseData:(id)data
{
	if (data && !_parser && !_error)
	{
		_parser = [[NSXMLParser alloc] initWithData:data];
        
		_items = [NSMutableArray new];
        
		[_parser setDelegate:self];
        
		[_parser setShouldProcessNamespaces:NO];
		[_parser setShouldReportNamespacePrefixes:NO];
		[_parser setShouldResolveExternalEntities:NO];
        
		[_parser parse];
	}
	else
	{
		_error = [NSError errorWithDomain:@"No data" code:0 userInfo:nil];
	}
}


- (void)setResponse:(NSURLResponse *)response
{
    _response = response;
}


- (NSError *)error
{
    return _error;
}


- (NSArray *)itemsArray
{
    return [NSArray arrayWithArray:_items];
}


- (void)abortParsing
{
    [_parser setDelegate:nil];
    [_parser abortParsing];
    _parser = nil;
    _error = [NSError errorWithDomain:@"Parsing aborted." code:299 userInfo:nil];
}


#pragma mark - Did start/end element


- (void)didStartElement
{
    
}

- (void)didEndElement
{
    
}


#pragma mark - Date/Time Format


- (NSString *)dateFormat
{
    return @"yyyy-MM-dd";
}


- (NSString *)dateTimeFormat
{
    return @"yyyy-MM-dd hh:mm:ss Z";
}


#pragma mark - NSXMLParserDelegate


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (string != nil)
	{
		[_mElementValue appendString:string];
	}
	else
	{
		_error = [NSError errorWithDomain:@"Parsing error! Appending nil value." code:-1 userInfo:nil];
		NSLog(@"Parsing error! Appending nil value.");
		[parser abortParsing];
	}
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	_error = parseError;
#if DEBUG
	NSLog(@"%@", [NSString stringWithFormat:@"Parsing error code %ld, %@, at line: %ld, column: %ld", (long)[parseError code], [[parser parserError] localizedDescription], (long)[parser lineNumber], (long)[parser columnNumber]]);
#endif
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	_mElementValue = [[NSMutableString alloc] init];
	_elementValue = nil;
	_elementName = [NSString stringWithString:elementName];
	_attributesDict = attributeDict;

	[self didStartElement];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	_elementName = [NSString stringWithString:elementName];
	_elementValue = [[NSString stringWithString:_mElementValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	[self didEndElement];
}


- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
	_mElementValue = [[NSMutableString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}


#pragma mark -


@end
