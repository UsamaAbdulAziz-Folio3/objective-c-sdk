//
// Created by Rahul Somasunderam on 9/4/14.
// Copyright (c) 2014 Underplot ltd. All rights reserved.
//
/****************************************************************************
 * Modifications to JSONModel by Optimizely, Inc.                           *
 * Copyright 2017, Optimizely, Inc. and contributors                        *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *    http://www.apache.org/licenses/LICENSE-2.0                            *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ***************************************************************************/

@import XCTest;

#import "NestedModel.h"
#import "ExtremeNestingModel.h"
#import "DrugModel.h"
#import "InteractionModel.h"

@interface ExtremeNestingTests : XCTestCase
@end

@implementation ExtremeNestingTests
{
	ExtremeNestingModel *n;
}

- (void)setUp
{
	[super setUp];

	NSString *jsonContents = @"{\n"
			"	\"generic_alternatives\": [\n"
			"		{\n"
			"			\"items\": [\n"
			"				{\n"
			"					\"data\": [\n"
			"						{\n"
			"							\"brand_name\": \"Novolog\",\n"
			"							\"interaction_list\": [\n"
			"								{\n"
			"									\"dxid\": 594,\n"
			"									\"text\": \"Novolog Mix 70-30 100 unit/mL subcutaneous solution is relatively contraindicated in patients with Renal Disease.<br/>The following patient diagnosis is related to, or may imply, that this condition exists:<ul><li>Diabetes with Renal Manifestations Type II or Unspecified Type, not Stated as Uncontrolled</li></ul><br/>This medication belongs to the following drug class or contains the following ingredient which is known to have clinically important considerations:<ul><li>INSULINS</li></ul> is relatively contraindicated in Renal Disease<br/>For additional information please refer to the manufacturer's monograph.\",\n"
			"									\"title\": \"Diabetes with Renal Manifestations Type II or Unspecified Type, not Stated as Uncontrolled (Renal Disease)\",\n"
			"									\"type\": \"DDX\"\n"
			"								}\n"
			"							]\n"
			"						}\n"
			"					]\n"
			"				}\n"
			"			]\n"
			"		}\n"
			"	]\n"
			"}";

	NSError *err;
	n = [[ExtremeNestingModel alloc] initWithString:jsonContents error:&err];
	XCTAssertNil(err, "%@", [err localizedDescription]);
	XCTAssertNotNil(n, @"Could not load the test data file.");
}

- (void)testNestedStructures
{
	XCTAssertEqual(n.drugs.count, 1);
	DrugModel *drug = n.drugs[0];
	XCTAssertEqualObjects(drug.brand_name, @"Novolog");

	XCTAssertEqual(drug.interaction_list.count, 1);
	InteractionModel *interaction = drug.interaction_list[0];

	XCTAssertEqualObjects(interaction.title, @"Diabetes with Renal Manifestations Type II or Unspecified Type, "
			"not Stated as Uncontrolled (Renal Disease)");
	XCTAssertEqualObjects(interaction.type, @"DDX");
}

@end
