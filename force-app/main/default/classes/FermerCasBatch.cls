/**
 * @description Classe pour fermer les cas en masse
 * @author AI Dev Team
 */
public with sharing class FermerCasBatch implements Database.Batchable<sObject>, Database.Stateless {
    
    // Méthode pour récupérer les enregistrements de Case à traiter
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Status, Subject FROM Case WHERE Status = \'In Progress\'';
        return Database.getQueryLocator(query);
    }
    
    // Méthode pour traiter les enregistrements de Case
    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Case> casesToUpdate = new List<Case>();
        for (sObject s : scope) {
            Case c = (Case)s;
            c.Status = 'Closed';
            if (String.isEmpty(c.Subject)) {
                c.Subject = 'Closed';
            }
            casesToUpdate.add(c);
        }
        
        // Mettre à jour les enregistrements de Case
        List<Database.SaveResult> results = Database.update(casesToUpdate, false);
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                for (Database.Error err : results[i].getErrors()) {
                    System.debug('Erreur sur ' + casesToUpdate[i].Id + ' : ' + err.getMessage());
                }
            }
        }
    }
    
    // Méthode pour finir le traitement
    public void finish(Database.BatchableContext BC) {
        // Envoyer une notification pour indiquer la fin du traitement
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setBody('Le traitement des cas est terminé.', 'text/plain; charset=UTF-8');
        mail.setSubject('Traitement des cas terminé');
        mail.setToList(new String[] {'destinataire@example.com'});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}