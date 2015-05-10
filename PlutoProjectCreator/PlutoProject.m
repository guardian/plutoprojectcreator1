//
//  PlutoProject.m
//  PlutoProjectCreator
//
//  Created by localhome on 10/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "PlutoProject.h"

@implementation PlutoProject

/*
+ (PlutoProject *)projectWithHeadline:(NSString *)head standfirst:(NSString *)stand byline:(NSString *)by trail:(NSString *)trail commission:(PlutoCommission *)comm
{
    PlutoProject *p = [PlutoProject alloc];
    
    [p setHeadline:head];
    [p setStandfirst:stand];
    [p setByline:by];
    *[p setTrail:trail];
    [p setCommission:comm];*
    
    return p;
}

+ (PlutoProject *)projectForCommission:(PlutoCommission *)comm
{
    PlutoProject *p = [PlutoProject alloc];
    
    //[p setCommission:comm];
    return p;
}
*/

/*
<MetadataDocument xmlns="http://xml.vidispine.com/schema/vidispine">
<revision>VX-3408,VX-3407</revision>
<timespan start="-INF" end="+INF">
<field uuid="a29f4eb7-b045-40d9-99e6-d47914786ad2" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">
<name>title</name>
<value uuid="fbac76e7-6112-41b9-b8e8-68811b37523b" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">Johan 3</value>
</field>
<field uuid="94ca48bd-ccc3-449b-b8dd-886bda460fc2" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_subtype</name>
<value uuid="056e8538-4c45-453e-a6eb-65f0da256e48" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">9b7b65fe-be66-4092-8832-e301683631c3</value>
</field>
<field uuid="8840347e-b72e-4a30-9adb-ccdb9771010b" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">
<name>collectionId</name>
<value uuid="8174d4a1-c7aa-41d4-8dd7-2ed10b046ee4" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">VX-77</value>
</field>
<field uuid="0c4e28c4-616d-449b-b4fe-6267e059ed6b" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_username</name>
<value uuid="065b2625-99b8-4ad8-b409-86a740de21b2" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">1</value>
</field>
<field uuid="146ae78a-4a97-4141-a3d1-ee09d8f0db6d" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">
<name>created</name>
<value uuid="6e82f5b3-e946-4b74-b11b-bc3e14d1d5a5" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">2015-04-27T15:00:47.554Z</value>
</field>
<field uuid="ca2dd189-c94c-4a69-a475-5ebb53ede42b" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_commission_workinggroup</name>
<referenced id="VX-76" uuid="d2e30ac7-df40-4fe2-a04b-da640fe6cd01" type="collection"/>
<value uuid="38ddfa73-7cee-4b76-b9ce-ce3a4f3e3b93" user="admin" timestamp="2015-04-27T16:00:46.347+01:00" change="VX-3406">67d0d0eb-c9d7-475a-8614-e06f6620e1ab</value>
</field>
<field uuid="61252914-bc31-4304-8fc0-d9ee60df5297" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">
<name>user</name>
<value uuid="6c01f482-dc20-44c2-b121-04bbe9c2bd9e" user="system" timestamp="2015-04-27T16:00:47.602+01:00" change="VX-3407">admin</value>
</field>
<field uuid="ddcd268f-a0b7-4d5d-8a7d-44094e079bd1" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_commission_title</name>
<referenced id="VX-76" uuid="afcca09c-6177-4193-a748-9a32053d10ae" type="collection"/>
<value uuid="c5789e14-7024-46b0-b4bf-8ef20583dd55" user="admin" timestamp="2015-04-27T16:00:46.347+01:00" change="VX-3406">Johan 3</value>
</field>
<field uuid="b3b90daa-9cd5-4d1f-9ce7-27a63cb877af" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_whollyowned</name>
<value uuid="ba4fcb75-3a04-4f50-b687-416786cf4a4e" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="2d9fe3f8-b28d-4e85-b050-ce7ac085e8ac" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_subscribing_groups</name>
<value uuid="a2437cc2-7a48-4a18-8348-025a3aa55a80" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="c82c2a4e-c26f-4a8e-ab79-b376c2f32b34" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_type</name>
<value uuid="7205d0ac-c5db-4989-8495-b80851cdae53" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">5243bc2e-a30b-42de-8567-97fcff4dd0ed</value>
</field>
<field uuid="1dff0c82-cc4b-4e18-9297-ba661f093b76" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_storage_rule_deep_archive</name>
<value uuid="b1abb5d2-92ca-4186-bf27-f8cda677d57e" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">storage_rule_deep_archive</value>
</field>
<field uuid="e5af7d06-38d3-4705-a98d-1b531d1d884a" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_ukonly</name>
<value uuid="6bf862cb-9780-4d2d-a864-f23006d8ae9b" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="50d40fdd-2eea-4f80-b4cf-179440ecd156" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_trail</name>
<value uuid="fb2b7b63-a484-4204-b06a-293d047b9928" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">Johan 3</value>
</field>
<field uuid="1c220010-2095-49d3-92f0-fdfb0e124ace" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_intendeduploadplatforms</name>
<value uuid="7ceea912-b6ae-4824-8b1e-0206e75d66f6" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="77b32f21-ca82-4521-b75a-fd58700ddd8e" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_standfirst</name>
<value uuid="0e57ed05-2df8-4023-a89b-91358ad1b1c8" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">Johan 3</value>
</field>
<field uuid="12d72fee-f3d9-429a-9d28-5b35d470abff" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_storage_rule_deletable</name>
<value uuid="0e9714be-524f-481b-80f3-8844f12a3fa4" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="522ce69b-34c5-48fc-b6b0-8eb9e43af376" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_subscribers</name>
<value uuid="b5ba8a2f-04ae-4abb-a1fc-46a11c756a0f" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">1</value>
</field>
<field uuid="f3dc8705-d322-4e21-8b57-6e57405e3fad" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_linktext</name>
<value uuid="76a07514-b080-425e-bd99-29d00a6d6edc" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">Johan 3</value>
</field>
<field uuid="ee616b5a-169f-4234-aff9-6e38c29d7993" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_status</name>
<value uuid="cca13a27-90a8-460f-b29c-c47455437fdd" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">New</value>
</field>
<field uuid="f930c4e9-8b91-41dd-9c08-0fb357b0b950" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_storage_rule_sensitive</name>
<value uuid="a0303f71-32ac-45bb-b6d7-86fbd8305ca2" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field uuid="6f59ab74-5374-423a-9311-6e4f76ec4867" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_type</name>
<value uuid="c3a7f3b4-8363-46e1-9598-5ae87cea4658" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">Project</value>
</field>
<field uuid="901eb7d1-8528-46ca-827c-6f0e556cbcaf" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_headline</name>
<value uuid="5105574c-fd1d-4f5d-a95f-1f70949e9553" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">Johan 3</value>
</field>
<field uuid="f25d07a3-2371-4e0d-9632-817aa2b8674b" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408">
<name>gnm_project_containsadultcontent</name>
<value uuid="3a45f372-53db-4f69-8af2-c8392ee325f4" user="admin" timestamp="2015-04-27T16:00:47.781+01:00" change="VX-3408"/>
</field>
<field>
<name>__metadata_last_modified</name>
<value>2015-04-27T16:00:47.781+01:00</value>
</field>
<field>
<name>__parent_collection_size</name>
<value>1</value>
</field>
<field>
<name>__parent_collection</name>
<value>VX-76</value>
</field>
<field>
<name>__child_collection_size</name>
<value>0</value>
</field>
<field>
<name>__ancestor_collection_size</name>
<value>1</value>
</field>
<field>
<name>__ancestor_collection</name>
<value>VX-76</value>
</field>
<field>
<name>__folder_mapped</name>
<value>false</value>
</field>
</timespan>
</MetadataDocument>
*/

- (bool)saveWithError:(NSError **)err
{
    /* relate our properties to Vidispine fieldnames for Pluto */
    NSDictionary *metaDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Project",@"gnm_type",
                              [self headline],@"gnm_project_headline",
                              [self headline],@"title",
                              
                              nil];
    
    /*fire off the create request*/
    return [self createWithMetadata:metaDict title:[self headline] error:err];
}


@end
