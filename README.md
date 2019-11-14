On the Opportunity object,validation rule prevent non-admin users from modifying the Opportunity Name once Probability is greater than 50% and apex code will prevent Opportunity from being deleted if Probability greater than or equal to 75%

Apex method leadDuplicateCheck will validate if a collection of new leads would create duplicates in the system and returns segregated lists in a map (True: list of non-duplicates & False: list of duplicates). A duplicate lead is defined as same Email, Territory__r.Region__c (text) and Company (text)
