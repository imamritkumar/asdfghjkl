// Trigger for update releted contact on Account object
trigger contactTrigger on Contact (after insert, after update, after delete) {
    if((Trigger.isInsert)){
		ContactHelper.UpdateAccount(Trigger.new);
	}
    if((Trigger.isUpdate )){
		ContactHelper.UpdateAccountUpdateCase(Trigger.new, Trigger.old);
	}
	if(Trigger.isDelete){
		ContactHelper.UpdateAccount(Trigger.old);
	}
}