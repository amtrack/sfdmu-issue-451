Account acc = new Account(Name='Test SFDMU Issue 451');
insert acc;
insert new Opportunity(Name='Test SFDMU Issue 451', StageName='Negotiation/Review', CloseDate=Date.newInstance(2022, 12, 31));
insert new Opportunity(Name='Test SFDMU Issue 451 2', AccountId=acc.Id, StageName='Needs Analysis', CloseDate=Date.newInstance(2022, 12, 31));
