public with sharing class OpportunityHelper {
    public static void avoidDeletion(List<Opportunity> oppList){
        for(Opportunity oppRec : oppList){
            if(oppRec.StageName == 'Closed Lost'){
                oppRec.addError('Your can\'t Delete '+oppRec.Name+' Opportunity');
            }
        }
    }
}