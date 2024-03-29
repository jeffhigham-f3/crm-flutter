import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/contact/import.dart';

const bool kiOSLocalizedLabels = false;
const String kSlugLead = 'lead';
const String kSlugCustomer = 'customer';
const String kSlugFollowUp = 'follow_up';
const String kSlugOnline = 'online';
const List<String> kContactUUIDs = [
  '010C866C-D812-446F-AA4C-5BF329CC89E2',
  '02A01007-F220-4A07-9128-1CE75DD56099',
  '02C9F83C-54DE-4DB0-87BD-A63674201A35',
  '02FCC71B-9D11-45BA-814E-A558D9DF40DA',
  '03F52702-45CD-47AF-8057-0C9E3C928C28',
  '061942FF-7406-4D51-BF38-ABF4F39A8E26',
  '0727F2F1-D6E7-496B-B3A6-F211290FF8DD',
  '077D9452-EDB9-4F0E-BAC4-6485BD436C12',
  '07CCCDA0-063D-4193-BA1B-368E81F96B27',
  '0843B594-7243-4C87-AD92-9196879FA6C4',
  '08D9B842-A5F4-44A4-964B-4CAB6F4EA9F3',
  '093588EB-171B-49D1-B2AF-E317277868B9',
  '094A19DC-0492-4552-B43F-EA1BC207AFF4',
  '09B2366A-8C16-4946-A5C1-5232E9C25157',
  '09D61DC4-1113-41C6-813B-966B0A5BF057',
  '09FE9835-6146-4277-9851-C6FFE8C584EB',
  '0A3CEF7C-04A6-455E-9007-6C8FF216FA6B',
  '0AF0317D-F563-47FB-BD3A-E793A15A1DDB',
  '0B51B84A-A50F-4BD3-A3B8-F98D62C99A98',
  '0C430BDF-8589-4375-9B49-CA3EB9B547EB',
  '0F3F8F70-5CEA-43FE-9AB9-5EA4AD272C52',
  '1072F0A5-4D17-4482-A692-818A9155EDE5',
  '116CEFBA-99EC-49CD-B5B2-3DC860C4C649',
  '123BF042-CA29-4D3A-8D7C-1F99C954920C',
  '124392F4-ACE3-463D-A344-09A076286FF7',
  '13A8A8A3-DEDC-462A-8B6E-77C00F96554D',
  '1418772B-2660-4405-97AB-90DC7055BB16',
  '14402C31-E59A-4074-B8D8-35D4980E1D88',
  '155C318D-32C6-44CF-9644-A8577FA7A65F',
  '157015C8-CBCB-44DE-81B5-117994BADACA',
  '1574BA8F-3F9B-4252-B824-250428C3AE07',
  '15F7CF09-D54C-4042-AA3B-F529E455C63F',
  '160EEBE5-A1C6-4395-BE47-969DC1CEB893',
  '16154570-4A04-402D-8722-12339B172087',
  '170AAAC9-6F99-48F2-81D4-9DD53207F8B9',
  '18D16625-8CAF-40E6-8D3E-BEB91F260CE9',
  '19C91769-4E07-480A-9537-F803071E64C4',
  '1A70235A-9AA2-4F04-A5BC-1D6CD43FC507',
  '1CF50765-3BA9-4EF6-8F0F-46A330BD495A',
  '1D8AB2E8-B850-4A0A-BCBB-31AA4F02FBB9',
  '21AE47D6-0EF7-48C7-8CA7-9A5E8516219E',
  '24709BF5-DAFD-4868-8CCF-AF35E020781A',
  '2508BA7F-622D-42D9-8395-83D26FB59A58',
  '2534F9D5-A849-47E0-8DEF-7B99370ACCF5',
  '26046FAC-816A-434E-A20F-40F0E909DB54',
  '26792651-1B1F-4BCD-8DAA-1AA5A670DDBB',
  '269E5CEB-797B-4F66-80B1-4B1D7DB51D07',
  '2788B1FB-E76B-492F-A984-D388E4AC4961',
  '2873EC38-2465-476A-AC9C-B3EFE830A4F0',
  '288D8281-3E38-43FE-96DB-A66D1BE4BA7E',
  '28C1BC56-BF76-4A19-9C2D-D49005B7E6EC',
  '2A5F7224-3F57-4715-B9D4-8D61F4F60573',
  '2AA8585D-9BDA-453C-BE7A-371B6DC03F9C',
  '2B5A1E9B-D1CB-4DFA-A431-95852AFD8022',
  '2BE3D2C9-0467-4698-B9EE-F61E475CBADE',
  '2CF76A1E-C223-42F5-A2F0-23DCBBB5B24B',
  '2D01DDC0-CC1F-4C01-8003-751320F18DD2',
  '2D3732DC-61ED-423F-9E02-A2F11D0CC4E3',
  '2F66D4AF-9786-4BD2-8529-C0AEF9C0A20E',
  '2FD01F14-744B-4BE6-A31C-09A86AB57DB2',
  '334BD847-5724-4DA7-B32D-3F552A972A3E',
  '33566585-1482-4E5D-9012-2AF9675E940E',
  '35027308-1A76-4654-9ACA-498B23C3DFB1',
  '3505C5DA-3E10-42A4-B887-B4341121C343',
  '358F4513-58C7-4ECC-98C6-15E7D1F3A3A6',
  '35966EC7-6B00-4A3D-8B38-75648C3356B7',
  '36B941E2-C5A3-4DB0-AB5A-959056A974C5',
  '370E7698-3F6E-4D90-8731-1A133521EE7F',
  '3721F4E2-913B-4360-88F4-3808AA07AFB1',
  '398A9DC6-A348-4F9E-A6D5-E3FCB7900F41',
  '39FA2EB4-8C9B-4FCB-B90C-BF24E39FC05C',
  '3A314316-7DD6-4246-B102-41C78388B91A',
  '3A494F1B-37DB-42D8-8871-16D2EDE2EA7D',
  '3B5F7098-73F8-4FB0-93E6-D56E943EF1A1',
  '3BE8A6B2-3E3E-4BC6-9258-F09064D9AF5D',
  '3C5235F4-431B-4E83-9A0B-9CCBABD29226',
  '3DDFF4B0-C6E0-4020-A5E0-B4224F43820C',
  '3EA357CE-D0CE-451A-ADD8-2F8393D1FA0E',
  '3F08F28E-9017-418B-BC53-4F14FFF721B8',
  '3F45389A-904A-4892-9558-D57B0F4EAD64',
  '41C40838-A4BE-40F2-B28E-A863D33D9A38',
  '445D7886-1473-4340-8A98-A82E14FAE8D9',
  '464F8A1B-3EF4-4203-BB38-3A3B55FB0E87',
  '48347856-BDB9-42A8-BF73-5529E1692997',
  '4868226A-2B4B-484C-AF52-A75D10AE8424',
  '49123912-C481-452E-B3E6-E34E89A4C917',
  '493CA8F3-12E7-4617-BB08-DD15B4E2CED5',
  '4A543268-2081-4485-BEFA-CD62F9376C1E',
  '4A95D35C-79D9-4107-A372-D5C89CF49A49',
  '4CBF1BEC-0089-4D81-9FF2-3984482926D6',
  '4CE08EBD-BA14-4198-8738-045E8E0BC88E',
  '4EF6CD4B-82AE-43B3-B42E-B733B1523A9D',
  '4F238929-B783-418A-B5B5-50450B6A6CE3',
  '50BA903F-7890-4A0C-9791-706D95BDDC0D',
  '52966AF6-D751-4377-984B-87609C7607D9',
  '53737C15-39C9-4039-9F64-E8BD51D132CE',
  '5581301B-6FCC-4F6B-AC7F-9DC4D2DA599B',
  '55AA6CC7-A88D-46BD-97B4-3C77032D3A10',
  '55E269B7-A1EC-4958-BD71-EF32B398E300',
  '5938A106-3563-4372-BC3F-FE4303B9D52B',
  '59F47ED2-E131-4649-B5E4-914F3CEC11A1',
  '5A708B16-A2E1-48A6-A8FD-8AD98897F56D',
  '5A8C71F9-0661-471F-BBCC-43BE59B69553',
  '5BB81AB3-43BB-41C0-B70C-46ADCCAD17C0',
  '5BEB631E-8CDC-484B-A1B4-054BC36B05AF',
  '5E635988-30E5-4D6A-B7D3-6B751EF778E6',
  '604E52ED-A300-4816-8D6C-170969450589',
  '6104AF0C-6ECB-4ECE-B722-92F734F90695',
  '61EFA994-7E66-4638-A7D1-082FE63EDE7A',
  '62BFFA2A-3581-4E25-8B11-50EA3F511538',
  '62E4DC95-8D88-433B-8A6A-A3F470E4D07E',
  '6335C2C8-07F3-48D0-ACF8-692AE3A95FBE',
  '639DCB96-E132-42E4-9114-31B0CDBDAB1E',
  '64DCE423-3E99-4984-84A8-01E7EC57D89A',
  '67141C48-84C0-49DB-833C-72AFC84AE913',
  '68153FC3-9EFE-4141-B53D-C217F6594482',
  '68728192-A3C9-4B3B-906E-C2B3AB359FA1',
  '68CC9EBA-8887-4546-B082-E9283956B07A',
  '68D057ED-8B48-40C1-84A5-D066199D0EBA',
  '6987559E-3BE0-4376-B1A6-57483E4E38D3',
  '69D481AB-0DC7-436C-A86B-E01557FC72BD',
  '6A891A01-E791-419D-9A32-F83ACAA99EC4',
  '6C517495-A9AB-4E50-AC44-ABD9DB4EC71A',
  '6CEC94F7-C189-498B-9B5A-E47DA7829A61',
  '6EAA0F65-1182-40F9-99C9-C4B126D5B7D3',
  '6F039511-54FD-48E0-9402-749113C4D17A',
  '6FA82140-D43A-4125-B306-1E6EAF6E9572',
  '6FDFE5AA-667B-4F52-8BEA-A3F80F542C36',
  '704C5328-7F8D-445F-8AB4-0E054D196D39',
  '7062A48C-DF61-48AB-AD6C-F94978A2EFA3',
  '71714BA1-D45B-4B93-B6A9-CCD1A86D7A50',
  '7213D5F2-54F5-4797-8336-C4DBE2C59147',
  '728CFC12-4859-4DE2-92B1-2F796F498764',
  '72FFE6A3-904F-4FD1-AC78-81B202DB7F47',
  '7323D8F5-5FCA-4681-9EA0-12CFBAF75EB0',
  '732DE3C3-CAD4-4EF7-A173-0D5676BD823B',
  '735550CB-5ED4-475B-8FAA-1FA924F89203',
  '7485AF3C-8619-4849-A1FE-F8CF5DC7D546',
  '75CA086D-EA9B-4FDB-BA46-E7FCF4F2CE72',
  '76E67D31-49BE-4171-8B0E-BD18785F50F1',
  '7727296D-A55A-42E0-8C32-C0B3E1B72F08',
  '78127C69-61BC-4ACE-849A-86DAAB16A805',
  '786478F6-CBAE-49C5-ADE7-1D7F8882B40D',
  '7892B9CC-7920-4610-A7B2-31CD1BD9CA6C',
  '79C381D8-9282-4D5A-B81A-007EAF99CFF4',
  '7A30B748-215D-41A4-98D2-BDED89B6D8D3',
  '7ACF5D1C-75A5-45F2-8499-21908895E4B2',
  '7AD5CCDF-8CC2-44C3-9F67-61CEF8212D22',
  '7F5D37AE-4D4C-4628-8952-5D54E169A39F',
  '83E6DC34-01E5-4D2B-99EE-C8F7486B1D8C',
  '84976DAC-EB11-4994-8032-CC9FF9D7A301',
  '8551532B-C90E-446D-9EFC-F8E0AD5F6FA3',
  '869EC407-2947-48C1-A4BE-CE3CFA7ADECB',
  '87038FAD-67A3-4104-998D-DEDD1C08FD22',
  '87A618F7-A0BB-420C-8B18-F4E92FC4A39E',
  '88456343-416C-45D5-9FE7-E5E3D06241AA',
  '8B320684-FEC3-409A-85F0-BA74CF296AC5',
  '8B8D19C6-B810-4D2E-8F40-251AA9E68FFA',
  '8BF9314A-4C89-4C63-8E4A-405A24E0E510',
  '8D860874-9F41-4D63-A084-89F5E4196A31',
  '8D8EF73D-63D8-4C0B-B184-6F8691F1BE14',
  '8DBAB476-8705-427A-AD54-CE8D3892B240',
  '8E230DED-E91C-4B36-B777-05A3E3B7A446',
  '8FA12794-3498-4D96-82B2-C8309CA25DC1',
  '90AAAFC7-34D8-4FAC-93DD-D976382573AD',
  '92534E70-E95F-4911-9CCB-D3793D33EC61',
  '93A645A8-973A-4AD8-8132-9DF206788540',
  '93AD906C-09C2-4058-B496-23FB38381632',
  '9496F082-0756-4D39-B3E9-4BD3E9071E2E',
  '94EE0871-5B00-42A5-BD6E-F232FF713E15',
  '95298E2F-4E84-4610-B634-3F09E0AB4CCF',
  '959DDCCD-AF74-45DC-A1D6-CAE81E4BAA28',
  '960AD6F6-4314-4453-A15B-8660FC89DA7D',
  '98442D11-4A95-40FB-83BC-DA1A5183BD2F',
  '9845128B-25B1-4CE4-ACC7-291653B331E8',
  '98C394A5-0067-468A-8EE8-84CCBA899915',
  '9918DCAA-1263-4F10-8DB2-0CF26C5B3982',
  '9954C311-DDDD-4E59-8759-5F6E668939A2',
  '999193FE-302B-4270-8739-6AF2224A2E3F',
  '9AF49156-DBBF-4C0B-A962-D1623E546145',
  '9B4C0F20-8368-4A4B-B552-5F65B0D5ABA1',
  '9C703A81-A296-4F44-9EA0-D2BFC04709B2',
  '9C84396B-BD29-4C2E-9A6D-3B88EBAC63D6',
  '9CB2C3D9-1648-47C5-BBE7-3627F6A4A86B',
  '9EB4A95A-89BE-44FB-8574-20FCE79B6FCD',
  '9F3466C2-7889-4AD3-8D2E-11F27BDF2AB8',
  '9F4ABEF8-7D75-4394-95E7-B7BE8FE35A5E',
  'A0E85CF3-E5CF-4AB4-BB3B-0CFB2B7B615E',
  'A1063FA0-6AD8-45A5-BAC9-E57E982873AF',
  'A17A9F31-90D5-4CD1-842F-C84BC89E816E',
  'A1B1A0D0-24DA-4DFE-B78D-D2EACC5C70B7',
  'A214D384-F968-4587-AE3A-DCAA5EB60A19',
  'A230BB09-DBE6-401A-B012-823288A50A67',
  'A2B43956-A59B-4ADA-B5C0-DF99AAF75A4C',
  'A38FD88B-BE6D-4C73-8464-A2FC4DA6820A',
  'A40B277E-B5F3-454A-AE12-055D5CF79FD7',
  'A517EADF-ACD6-4328-AE42-05AC44DA312B',
  'A655F9C4-6D47-4491-88E6-840C306B0A3A',
  'A65B9B2A-440E-451B-9723-E6D1C6159DEE',
  'A82C2919-FA9C-44FA-AEE9-CB18E86D07F7',
  'A9125125-69EE-4DEE-AF80-9155E24C0C43',
  'A91D1BFB-7DE6-4EF7-8942-F518E09540CB',
  'A94B1740-2F88-4AAF-9123-A22987DF2B0E',
  'AABBF71A-6C94-4548-A45B-59FFC3D8C193',
  'AB0E72BF-5730-47EF-8A39-AC9B71EB1EF8',
  'ABF5071B-533D-404F-A1A0-497C1E6A4CA5',
  'AC92D341-8B52-4B55-BDFC-190DC12DC544',
  'ACD56B0E-74B2-457B-B8A6-E8AEC83BB3FD',
  'ACDCFE27-64FC-42E7-9B75-21E14D6A7FCA',
  'AD1D24EC-7A27-4F27-8325-7D5B7621C84A',
  'AD4AB866-DEB6-4000-AE4B-01AA60B6CA9A',
  'AE133DA9-607C-436B-8697-F4EB440451AF',
  'AF7785AA-9DE0-40C7-B261-2A6FE17ABE80',
  'AF9E971A-6EEA-4880-810E-4E575C830770',
  'B0B06E59-A4BB-4F3F-9E82-8EEC494123A8',
  'B1904D27-E857-4DDB-8A2D-DFBB2959938A',
  'B1C5D639-FCE2-4422-8E1C-DC03823BFC64',
  'B1D39974-7F99-49D5-B3A6-C36864598661',
  'B2573F55-1F50-4C0B-8FF6-7FD22CA7EDDA',
  'B40288FA-5692-4C59-8B10-AA8779EF1E69',
  'B4611241-850C-422C-A8B3-EF8BD9993654',
  'B5F4348B-3AA5-4356-B208-57208934A9A5',
  'B5FB2AC7-D3B8-4411-846C-0B65837A6732',
  'B6ADB125-9DA5-42D0-9356-D181326B4510',
  'B82B9150-69AA-402C-ABEA-8AC52CE18FC3',
  'B977ADEE-73D1-4862-8596-699DF947A110',
  'BA1FE656-B797-4534-B484-10ECFB65FEBC',
  'BA8935C3-26C9-4232-A1E1-25FD78B346B4',
  'BAC5BF75-7408-44F6-B5F3-E32BAE4C49D1',
  'BB290F6E-1638-4435-BD05-1FBF01D6A534',
  'BBA7519E-0640-407B-B52F-962C0F1C1577',
  'BC736124-4F24-472B-B2F4-0D71CFB4E7FB',
  'BD71AFF0-1500-4AD3-8F47-2EF13E43DA18',
  'BF668E82-3023-4AF4-BE1A-CD798D98DDDB',
  'BFD2BA14-CFFD-47CD-A1DE-E73E2E7D0749',
  'C0742B61-E9A3-44A5-88CC-F3ED28C78C33',
  'C280D8B4-A018-4B67-B714-28F7EDAA5BD3',
  'C3CEE544-8AAC-4C1F-9CF1-841B5E87AD2E',
  'C5F10813-1CA9-4F96-BD04-555075CF4327',
  'C651711F-F585-4B82-AC6C-B35FA9639D9C',
  'C6B6F07D-812D-4354-BD4B-BDBC49B4F3AA',
  'C8B01538-05CD-4FD4-8149-0B04DA726F0D',
  'C91C33B4-47B2-4B77-A1D7-26E30DCFF57A',
  'C98B4F26-49CA-450A-8F5B-4B874CE504EA',
  'C99756F1-4339-4D4D-B02D-477574E934BE',
  'CB99F9E3-6A36-4565-A903-BB3D8CC0CEC2',
  'CBE7B78D-682E-45C9-B112-32EA7B2A56AE',
  'CC1648B6-9546-4D0C-8D9B-4AD0136E8BA5',
  'CCD621AE-8324-4A2E-BA18-740238FB41A3',
  'CD475A90-A81F-49B0-8C51-EC063A64122A',
  'CD7015FD-5994-46B0-9145-F4B22BEE5D66',
  'CD85B946-CCC4-44C4-8A7C-F8524F62DA22',
  'CD9BA4A2-D88A-4560-9E1B-A2B38C2A2716',
  'CE04BD97-8284-4FF4-8659-90D5E2E2483E',
  'CE0E6FF5-AB38-417B-A707-0F39AE9A89D8',
  'CF8187C6-FA72-4865-8F5B-C9E3B300B246',
  'CFD5AACC-77D1-44FA-8095-AD71B395F99C',
  'D0597AFF-FA37-4410-BEA8-8BFAE40BCBC8',
  'D07A0B80-4F80-45F9-8D2F-DB079594D7F4',
  'D2916EAD-CE0A-403D-9854-CD4DB95DB8AD',
  'D3167FD2-31F6-4B21-9E25-5CFFA907A5BB',
  'D41AFFAD-A39C-4FF5-AA8D-18D8488C5BC7',
  'D5EA88FE-2C25-4F6F-83BD-F022B5B22E48',
  'D61AA33D-C690-41EC-AF34-855C6C84D1FE',
  'D6B65014-3E79-4276-BFEF-4F5D0407838D',
  'D6DA9F24-CB6D-4207-AECD-A3000173F4D0',
  'D7530331-6EB2-47ED-9080-443A0916644A',
  'D94C86C7-3238-4AFF-B9ED-1977C6D34829',
  'DCA7C9A1-16FE-456A-94B0-53EE7DF38A4C',
  'DD7942FE-1259-46E9-9D36-50177A6819B6',
  'DE452009-7A6B-47F8-B3F2-3E7FD487BC3A',
  'DE626458-53B8-4009-8E34-7A2678EA70A5',
  'DE8C08C9-FBF6-4AC6-AE4F-35BD4CBB4DDD',
  'DF1CCF40-0F7E-42C1-BC34-31B62A8220CC',
  'DF4372E8-352B-42E4-AF7F-9CF24990791D',
  'DF624809-93FB-4588-8E69-A0434C5573E2',
  'E00E0750-0404-4DA9-B635-FEE197320496',
  'E0C66915-F3A5-4320-AF1D-A288288E2EA1',
  'E182AB21-D179-4D3D-92E9-2C7DCB9B8DF8',
  'E1EA3741-69DA-42AC-83C4-0B8DFD1A6148',
  'E36B6EDD-CCE9-4F6B-953F-B411A87494DC',
  'E49BDDF3-BD96-4060-8964-58326881E72B',
  'E7443F16-DAE0-41A9-B7BA-FD197FCCF3CE',
  'E749FEF8-15E0-42B5-840A-3F41D10A0302',
  'E7C03C37-2AEC-4930-A3BE-9F2EDFEA863C',
  'E8A4DB79-0D07-491E-A8AD-401E80C41E5E',
  'E93E850B-4F62-410B-B84C-5E2E5B498474',
  'E9D601F5-FB1B-456D-9593-0CAC3A0E5B60',
  'EA8E796C-A27F-401B-AB45-2FD2E2C7C9A0',
  'EE954827-877D-430A-BFAE-D66EC1160F80',
  'EFAA6E1D-D137-4B73-BAE8-A4C04949AE71',
  'EFF35CAA-5CD7-47DA-A742-1B7A7C238AF1',
  'F19E1138-F4A1-4207-801D-006A77AFAA89',
  'F3B058E2-8C28-4AAC-B7F0-A2BEE5E0A6C6',
  'F4B087B7-5EF2-4882-B7E8-B025B11D1B8D',
  'F5817E1E-E839-404F-8AEE-415CE67BBEAD',
  'F585CA32-76F7-49BA-9E25-DBE8637F748C',
  'F5B1D15C-97AC-474D-8C22-2B4D4843BB90',
  'F5D66436-5D6B-4378-A689-185465A20B00',
  'F626CC8C-5E7D-4D52-B503-4733D65F3E0A',
  'F723E644-0900-4F23-AE5E-F74D670CDFF8',
  'F75D2A69-6936-46B5-9DCB-E6E1F092C4DC',
  'FB940243-C4DA-44A9-85AF-A4A5F794C10E',
  'FD6BA9CC-AA2D-4082-887D-62157511D8D0',
  'FDA43F3A-5DFB-4756-BF2A-EDD2EDD96E52',
  'FFB5A4CE-4192-4D2B-A907-8919A7DE8063'
];

const List<Map<String, dynamic>> kAppInstances = [
  {
    'name': 'HubSpot',
    'slug': 'hubspot',
    'icon': FontAwesomeIcons.hubspot,
    'description': 'Grow traffic, convert leads, close deals, and turn customers into promoters.',
    'enabled': false,
    'id': 'DFEB08D0-4872-4A0E-846E-577061A4829D',
    'appType': AppType.CRM,
    'appProduct': AppProduct.HubSpot,
    'features': [
      {
        'id': 'FC5D0C62-F413-4AE3-9192-56D18B4E03B1',
        'enabled': false,
        'featureType': AppFeatureType.Contact,
      }
    ]
  },
  {
    'name': 'Salesforce',
    'slug': 'salesforce',
    'icon': FontAwesomeIcons.salesforce,
    'description': 'Make Insightful Decisions. Accelerate Productivity.',
    'enabled': false,
    'id': 'D64162EA-221C-4E3A-AC46-6DCF8D469032',
    'appType': AppType.CRM,
    'features': [
      {
        'id': 'AEF74B60-F93B-4D32-ABC2-D9CDEB83AA5E',
        'enabled': false,
        'featureType': AppFeatureType.Contact,
      }
    ]
  },
  {
    'name': 'Google',
    'slug': 'google',
    'icon': FontAwesomeIcons.google,
    'description': 'The Google tools you love for work, all in one place. Innovative Tools. Grows with your business.',
    'enabled': false,
    'id': '2BBC6B22-9F46-45A5-8ED1-7921C04F25A5',
    'appType': AppType.CRM,
    'appProduct': AppProduct.Google,
    'features': [
      {
        'id': '978D7B56-5918-409D-A029-19CCF59026CE',
        'enabled': false,
        'featureType': AppFeatureType.Contact,
      },
      {
        'id': '497951A0-3CD0-4704-8233-1235953E21EF',
        'enabled': false,
        'featureType': AppFeatureType.Media,
      }
    ]
  },
  {
    'name': 'Mobile Device',
    'slug': 'device',
    'icon': FontAwesomeIcons.mobileAlt,
    'description': 'Access contacts, photos, and media on your phone.',
    'enabled': false,
    'id': '435C7D0D-FA94-499B-84FC-150340637F9C',
    'appType': AppType.Device,
    // TODO: - dynamically assign based on platform.
    'appProduct': AppProduct.IOS,
    'features': [
      {
        'id': 'C6B2B4AF-EC57-4AF7-8C08-DEC790D27F9B',
        'enabled': false,
        'featureType': AppFeatureType.Contact,
      },
      {
        'id': '017B9EEE-5CA6-4D11-B870-A683B60BAF20',
        'enabled': false,
        'featureType': AppFeatureType.Media,
      }
    ]
  },
  {
    'name': 'Verb CRM',
    'slug': 'verb-crm',
    'icon': FontAwesomeIcons.server,
    'description': 'The #1 Sales Enablement Platform',
    'enabled': false,
    'id': 'ECAF5DF1-F4F8-40AC-BF1F-CFFC55F4C036',
    'appType': AppType.CRM,
    'appProduct': AppProduct.Verb,
    'features': [
      {
        'id': '40FCA778-57B6-4DD4-AA89-00B396C608E7',
        'enabled': false,
        'featureType': AppFeatureType.Contact,
      },
      {
        'id': '8AAE6676-4008-45C1-96BA-901A86A08158',
        'enabled': false,
        'featureType': AppFeatureType.Media,
      }
    ]
  }
];
