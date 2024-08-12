donnees <- read.table('~/Downloads/data1.txt', header=TRUE, sep=" ", stringsAsFactors=FALSE)

View(donnees)
str(donnees)

#convertir les variables de caractères en variables catégorielles
donnees$vent <- as.factor(donnees$vent)
donnees$pluie <- as.factor(donnees$pluie)

#utilisez la méthode ascendante 
model <- lm(maxO3 ~ T9 + T12 + T15 + Ne9 + Ne12 + Ne15 + Vx9 + Vx12 + Vx15 + maxO3v + vent + pluie, data = donnees)
null_model <- lm(maxO3 ~ 1, data = donnees)
step(null_model, scope = list(lower = null_model, upper = model), direction = "forward")

# Modèle 1 : Inclut T12, maxO3v et Ne9
model1 <- lm(maxO3 ~ T12 + maxO3v + Ne9 + Vx9, data = donnees)

summary(model1)

# Modèle 2 : Inclut T12 et maxO3v
model2 <- lm(maxO3 ~ T12 + maxO3v + Ne9, data = donnees)

# Effectuer le test de Fisher
anova_result <- anova(model2, model1)

# Afficher les résultats
print(anova_result)


