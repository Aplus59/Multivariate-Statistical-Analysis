# Installer les packages nécessaires
install.packages("readxl")
install.packages("DescTools")

# Charger le package readxl
library(readxl)

# Lire les données depuis un fichier Excel
data <- read_excel("C:/bt/Nam3/tknb/pj/data2.xlsx")

# Afficher les données
print(data)

# Convertir la colonne 'Traitement' en facteur
Traitement <- factor(data$Traitement)

# Extraire la colonne 'Blancheur'
Blancheur <- data$Blancheur

# Créer un data frame avec les variables 'Traitement' et 'Blancheur'
data_o <- data.frame(Traitement, Blancheur)

# Vérifier le data frame créé
print(data_o)

# Supprimer les anciennes variables pour libérer de la mémoire
rm(Traitement) 
rm(Blancheur)

# Afficher la structure du data frame
str(data_o)

# Joindre les variables du data frame pour simplifier l'accès
attach(data_o) 

# Test de Shapiro-Wilk pour vérifier si la distribution est normale
shapiro.test(Blancheur[Traitement == 'T1'])
shapiro.test(Blancheur[Traitement == 'T2'])
shapiro.test(Blancheur[Traitement == 'T3'])
shapiro.test(Blancheur[Traitement == 'T4'])

# Test de Bartlett pour vérifier si les variances sont homogènes entre les groupes
bartlett.test(Blancheur ~ Traitement)

# Transformation des données en utilisant la transformation logarithmique
log_Blancheur <- log(Blancheur)

# Créer un nouveau data frame avec les données transformées
data_log <- data.frame(Traitement, log_Blancheur)

# Afficher le nouveau data frame
print(data_log)

# Supprimer la variable transformée pour libérer de la mémoire
rm(log_Blancheur) 

# Détacher le data frame précédent pour éviter les conflits de noms
detach("data_o")

# Joindre les variables du nouveau data frame pour simplifier l'accès
attach(data_log) 

# Test de normalité sur les données transformées
shapiro.test(log_Blancheur[Traitement == 'T1'])
shapiro.test(log_Blancheur[Traitement == 'T2'])
shapiro.test(log_Blancheur[Traitement == 'T3'])
shapiro.test(log_Blancheur[Traitement == 'T4'])

# Test de l'homogénéité des variances sur les données transformées
bartlett.test(log_Blancheur ~ Traitement)

# Ajuster un modèle ANOVA avec les données transformées
mod <- aov(log_Blancheur ~ Traitement, data = data_log)
summary(mod)

# Test de Tukey pour les comparaisons multiples
TukeyHSD(mod)

# Utiliser le package DescTools
library(DescTools)

# Effectuer le test de Scheffe pour les comparaisons multiples
ScheffeTest(mod)
