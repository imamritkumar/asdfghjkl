trigger OpportunityTrigger on Opportunity (before delete) {
    if(Trigger.isDelete){
        OpportunityHelper.avoidDeletion(Trigger.old);
    }
}