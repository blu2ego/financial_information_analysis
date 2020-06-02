train_kospi_1st$FDEPS <- as.factor(train_kospi_1st$FDEPS)
y <- "FDEPS"
x <- names(train_kospi_1st)[!names(train_kospi_1st) %in% y]
train_kospi_h2o <- as.h2o(train_kospi_1st, "train_kospi_h2o")

glm_model <- h2o.glm(x = x, y = y, training_frame = train_kospi_h2o, model_id = "glm_model", family = "binomial")

gbm_model <- h2o.gbm(x = x, y = y, training_frame = train_kospi_h2o, model_id = "gbm_model", ntrees = 100)

xgb_model <- h2o.xgboost(x = x, y = y, training_frame = train_kospi_h2o, validation_frame = valid,booster = "dart", normalize_type = "tree", seed = 1234)

explainer <- lime::lime(x)
