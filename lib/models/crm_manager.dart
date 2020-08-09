import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm.dart';

class CrmManager with ChangeNotifier {
  final List<Crm> entities = [
    Crm(
      name: 'Agile CRM',
      logo: 'AgileCRM.svg',
    ),
    Crm(
      name: 'amoCRM',
      logo: 'amoCRM.svg',
    ),
    Crm(
      name: 'Anaconda',
      logo: 'Anaconda.svg',
    ),
    Crm(
      name: 'Autotask Pro',
      logo: 'AutotaskPro.svg',
    ),
    Crm(
      name: 'Base',
      logo: 'Base.svg',
    ),
    Crm(
      name: 'Benchmark',
      logo: 'Benchmark.svg',
    ),
    Crm(
      name: 'Capsule CRM',
      logo: 'CapsuleCRM.svg',
    ),
    Crm(
      name: 'Clarifysoft',
      logo: 'Clarifysoft.svg',
    ),
    Crm(
      name: 'Close.io',
      logo: 'Close.io.svg',
    ),
    Crm(
      name: 'Cosential',
      logo: 'Cosential.svg',
    ),
    Crm(
      name: 'CRMNEXT',
      logo: 'CRMNEXT.svg',
    ),
    Crm(
      name: 'Dynamo',
      logo: 'Dynamo.svg',
    ),
    Crm(
      name: 'Freshsales',
      logo: 'Freshsales.svg',
    ),
    Crm(
      name: 'FreshWorks',
      logo: 'FreshWorks.svg',
    ),
    Crm(
      name: 'Infusionsoft',
      logo: 'Infusionsoft.svg',
    ),
    Crm(
      name: 'Insightly',
      logo: 'Insightly.svg',
    ),
    Crm(
      name: 'LeadMaster',
      logo: 'LeadMaster.svg',
    ),
    Crm(
      name: 'LeadSquared',
      logo: 'LeadSquared.svg',
    ),
    Crm(
      name: 'LionDesk',
      logo: 'LionDesk.svg',
    ),
    Crm(
      name: 'Oracel CRM',
      logo: 'OracleCRM.svg',
    ),
    Crm(
      name: 'Pegasystems',
      logo: 'Pegasystems.svg',
    ),
    Crm(
      name: 'Pipedrive',
      logo: 'Pipedrive.svg',
    ),
    Crm(
      name: 'PipelineDeals',
      logo: 'PipelineDeals.svg',
    ),
    Crm(
      name: 'Pipeliner',
      logo: 'Pipeliner.svg',
    ),
    Crm(
      name: 'Raider\'s Edge\nNXT',
      logo: 'Raider_s_Edge_NXT.svg',
    ),
    Crm(
      name: 'SalesForce',
      logo: 'Salesforce.svg',
    ),
    Crm(
      name: 'SalesforceIQ',
      logo: 'SalesforceIQ.svg',
    ),
    Crm(
      name: 'SAP CRM',
      logo: 'SAPCRM.svg',
    ),
    Crm(
      name: 'ServiceNow',
      logo: 'ServiceNow.svg',
    ),
    Crm(
      name: 'SugarCRM',
      logo: 'SugarCRM.svg',
    ),
    Crm(
      name: 'Virtuous CRM',
      logo: 'VirtuousCRM.svg',
    ),
    Crm(
      name: 'Vlocity',
      logo: 'Vlocity.svg',
    ),
    Crm(
      name: 'Vtiger',
      logo: 'Vtiger.svg',
    ),
    Crm(
      name: 'Workbooks',
      logo: 'Workbooks.svg',
    ),
    Crm(
      name: 'X2Engine',
      logo: 'X2Engine.svg',
    ),
    Crm(
      name: 'Zendesk Sell',
      logo: 'ZendesSell.svg',
    ),
    Crm(
      name: 'Zoho CRM',
      logo: 'ZohoCRM.svg',
    )
  ];

  toggle({Crm crm}) {
    crm.enabled = !crm.enabled;
    this.notifyListeners();
  }
}
