# Multivariate-Statistical-Analysis
## Analysis of Factors Influencing Child Height Based on Family Characteristics

### Literature Review
The correlation between parents' height and their children's height has long been a subject of study, often considered a classic example of human genetics. This relationship reflects both genetic influences and environmental factors, such as nutrition and overall health.

### Data Overview
The dataset, which contains 898 entries, was collected when the children were 18 years old and includes the following variables:
- **Family:** Unique identifier for each family.
- **Father:** Father's height in inches.
- **Mother:** Mother's height in inches.
- **Gender:** Child's gender.
- **Height:** Child's height in inches.
- **Kids:** Number of children in the family.

The data is sorted by father's height and contains no missing values.

### Data Preparation
1. **Reading Data:** Loaded the dataset and assigned column names.
2. **Outlier Removal:** Detected and removed outliers using the IQR method.

### Model Presentation

#### Theoretical Model
A multiple linear regression model was applied:

Y = β_0 + β_1 X_1 + β_2  X_2 + β_3 X_3 + β4 X_4 + \epsilon

Where:
- Y is the dependent variable (child's height).
- β_0 is the intercept.
- X_1, X_2, X_3, and X_4 are independent variables (father's height, mother's height, child's gender, number of children).
- β_1,β_2,…,β_4 are the regression coefficients for each independent variable.
#### Model Selection
A forward stepwise method was used to select the best model based on AIC criteria. The final model includes:
- Father's height
- Mother's height
- Child's gender

The number of children was excluded as it had no significant impact.

#### Final Model
The final regression model is:
\[
Y = 15.55 + 0.40 \times \text{Father's Height} + 0.32 \times \text{Mother's Height} + 5.21 \times \text{Gender (Male = 1)}
\]

This model indicates that the child's height is significantly influenced by the height of the parents and the gender of the child.

# Report
## French version: 
https://studenthcmusedu-my.sharepoint.com/:b:/g/personal/21126021_student_hcmus_edu_vn/EXJyKPukN3xEg5gPX8w3BBIBNwkaA13XcfXcGHmyXQjp-Q?e=dkZGNR
## English version: (COMING SOON) 



