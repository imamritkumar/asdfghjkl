public with sharing class ContactHelper {
    public static void UpdateAccount(list<Contact> contactRec){
        Set<Id> accId = new Set<Id>();
        for(Contact con : contactRec){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
        if(accId.size() > 0){
            ContactHelper.updateAccountRecordList(accId);
        }
    }

    public static void UpdateAccountUpdateCase(list<Contact> contactRec, List<Contact> oldContact){
        Set<Id> accId = new Set<Id>();
        for(Contact con : contactRec){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
        for(Contact oldCon : oldContact){
            if(oldCon.AccountId != null){
                accId.add(oldCon.AccountId);
            }
        }
        if(accId.size() > 0){
            ContactHelper.updateAccountRecordList(accId);
        }
    }

    public static void updateAccountRecordList(set<id> accIds){
        list<Account> accList = [SELECT Id, Total_Number_Of_Contact__c, (SELECT ID FROM Contacts) FROM Account WHERE Id =: accIds];
        for(Account acc : accList){
            acc.Total_Number_Of_Contact__c = acc.Contacts.size();
        }
        update accList;
    }
}