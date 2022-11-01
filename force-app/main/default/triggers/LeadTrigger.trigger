trigger LeadTrigger on Lead (before insert, before update) {

	LeadTriggerHandler.execute(Trigger.new, Trigger.oldMap);
}