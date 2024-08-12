data <- read.csv('C:/bt/Nam3/tknb/Pj/data.csv', header = FALSE)
colnames(data) <- c("family", "father", "mother", "gender", "height", "kids")

data$gender <- as.factor(data$gender)
print(data$gender)

data$kids_group <- cut(data$kids, breaks = c(-Inf, 2, 4, 6, Inf),
                       labels = c("1-2 enfants", "3-4 enfants", "5-6 enfants", "7+ enfants"))

# Détection et suppression des outliers
# Calcul de Q1, Q3 et de l'IQR
Q1 <- quantile(data$height, 0.25, na.rm = TRUE)
Q3 <- quantile(data$height, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

# Définition des seuils inférieurs et supérieurs
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

# Détection des outliers
outliers <- data$height < lower_bound | data$height > upper_bound
table(outliers) # Affiche le nombre d'outliers

# Suppression des outliers
data_clean <- data[!(data$height < lower_bound | data$height > upper_bound), ]
boxplot(data_clean$height, main = "Boxplot de la hauteur (Données nettoyées)")

boxplot(data$height, main = "Boxplot de la hauteur")

modele_full = lm(data_clean$height ~ data_clean$father + data_clean$mother + data_clean$gender + data_clean$kids, data = data_clean)

modele_0 <- lm(data_clean$height ~ 1, data = data_clean)

mod_best = step(modele_0, direction = "forward", scope = list(lower = modele_0, upper = modele_full))
modele_selected = lm(data_clean$height ~ data_clean$father + data_clean$mother + data_clean$gender, data = data_clean)

anova_result <- anova(modele_selected, mod_best)

# Affiche les résultats
print(anova_result)

levels(data$gender)
contrasts(data$gender)

coef(modele_selected)
summary(modele_selected)

summary(modele_full)

shapiro.test(residuals(modele_full))
shapiro.test(residuals(modele_selected))
# Charger le package nécessaire
library(MASS)

# Construire le modèle initial
modele_selected = lm(data_clean$height ~ data_clean$father + data_clean$mother 
                         + data_clean$gender, data = data_clean)

# Effectuer le test de Box-Cox
boxcox_result = boxcox(modele_full)

# Trouver la valeur lambda optimale
lambda_optimal = boxcox_result$x[which.max(boxcox_result$y)]
print(lambda_optimal)

# Appliquer la transformation de Box-Cox à la variable height
data_clean$height_bc = (data_clean$height^lambda_optimal - 1) / lambda_optimal

# Construire un modèle de régression linéaire avec la transformation de Box-Cox
modele_selected_bc = lm(data_clean$height_bc ~ data_clean$father + data_clean$mother 
                          + data_clean$gender, data = data_clean)

# Vérifier la distribution des résidus
shapiro.test(residuals(modele_selected_bc))

#ANNOVA
# Créer des groupes selon le nombre d'enfants

# Étape 3 : Réaliser l'ANOVA avec les données nettoyées
data_clean$height_log <- log(data_clean$height + 1)
anova_result_clean <- aov(height_log ~ kids_group, data = data_clean)
summary(anova_result_clean)

# Tracer le graphique Tukey HSD pour l'ANOVA avec les données nettoyées
TukeyHSD(anova_result_clean)
plot(TukeyHSD(anova_result_clean))

# Étape 4 : Vérification des hypothèses du modèle ANOVA
# Vérifier la distribution normale des résidus
shapiro.test(anova_result_clean$residuals)

# Étape 5 : Vérification de l'homogénéité des variances
# Test de Bartlett
bartlett.test(height_log ~ kids_group, data = data_clean)



