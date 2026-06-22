// Classe Batch Apex pour mettre à jour les cas dont le statut est "En cours" vers "Fermé"
global class MettreAJourCasBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    // Variable pour stocker les cas à mettre à jour
    global List<Case> casesAMettreAJour = new List<Case>();
    
    // Méthode pour récupérer les cas dont le statut est "En cours"
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Requête SOQL pour sélectionner les cas dont le statut est "En cours"
        String query = 'SELECT Id, Status FROM Case WHERE Status = \'En cours\'';
        return Database.getQueryLocator(query);
    }
    
    // Méthode pour traiter les cas en blocs
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        // Boucler sur les cas du bloc actuel
        for (sObject so : scope) {
            Case cas = (Case) so;
            // Ajouter le cas à la liste des cas à mettre à jour
            casesAMettreAJour.add(cas);
        }
        
        // Mettre à jour les cas en blocs pour respecter les limites de gouvernance de Salesforce
        if (casesAMettreAJour.size() >= 100) {
            mettreAJourCas();
        }
    }
    
    // Méthode pour mettre à jour les cas
    global void mettreAJourCas() {
        try {
            // Mettre à jour le statut des cas vers "Fermé"
            for (Case cas : casesAMettreAJour) {
                cas.Status = 'Fermé';
            }
            update casesAMettreAJour;
            // Réinitialiser la liste des cas à mettre à jour
            casesAMettreAJour.clear();
        } catch (DmlException e) {
            // Gérer les exceptions de mise à jour
            System.debug('Erreur de mise à jour des cas : ' + e.getMessage());
            // Enregistrer les erreurs pour examen ultérieur
            insert new Erreur__c(Nom__c = 'Erreur de mise à jour des cas', Description__c = e.getMessage());
        }
    }
    
    // Méthode pour finir le processus de mise à jour
    global void finish(Database.BatchableContext BC) {
        // Mettre à jour les cas restants
        if (!casesAMettreAJour.isEmpty()) {
            mettreAJourCas();
        }
    }
}