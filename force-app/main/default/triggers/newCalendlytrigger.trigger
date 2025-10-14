trigger newCalendlytrigger on Calendly__CalendlyAction__c (After insert, After Update) {
    
    if(trigger.isAfter)
    {
        if(Trigger.isinsert)
        {
            CalendlyActionhandlerClass.CalendlyapexTriggerMethod(Trigger.New);
            CalendlyActionhandlerClass.toCanceltheEvent(trigger.new);
        }
    }
}