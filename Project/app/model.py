import pandas as pd
import numpy as np
from pathlib import Path
import joblib

from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor

# for splitting
from sklearn.model_selection import train_test_split

# for scaling of data
from sklearn.preprocessing import StandardScaler

# df=pd.read_csv('data/gold_price_data.csv')

BASE_DIR = Path(__file__).resolve().parent.parent

LINEAR_MODEL_PATH = BASE_DIR / "models" / "Linear" / "linear_model.pkl"
LINEAR_SCALER_PATH = BASE_DIR / "models" / "Linear" / "linear_scaler.pkl"

RANDOMFOREST_MODEL_PATH = BASE_DIR / "models" / "RandomForest" / "rf_model.pkl"

def read_linear_files():
    model= joblib.load(LINEAR_MODEL_PATH)
    scaler= joblib.load(LINEAR_SCALER_PATH)

    return model, scaler

def read_rf_files():
    model= joblib.load(RANDOMFOREST_MODEL_PATH)

    return model

# def linear_model():
#     features= [ 'SPX', 'USO', 'SLV', 'EUR/USD']
#     target='GLD'

#     X= df[features]
#     Y= df[target]

#     X_train, X_test, Y_train, Y_test = train_test_split(
#         X, Y, test_size= 0.3, random_state=42,
#     )

#     scaler= StandardScaler()
#     X_train_scale= scaler.fit_transform(X_train)
#     X_test_scale= scaler.transform(X_test)

#     model= LinearRegression()

#     model.fit(X_train_scale,Y_train)
#     Y_pred = model.predict(X_test_scale)

#     joblib.dump(model, LINEAR_MODEL_PATH)
#     joblib.dump(scaler, LINEAR_SCALER_PATH)

#     return model,scaler

# def random_forest_model():
#     features= [ 'SPX', 'USO', 'SLV', 'EUR/USD']
#     target='GLD'

#     X= df[features]
#     Y= df[target]

#     X_train, X_test, Y_train, Y_test = train_test_split(
#         X, Y, test_size= 0.3, random_state=42,
#     )


#     rf_model= RandomForestRegressor()

#     rf_model.fit(X_train,Y_train)
#     Y_pred = rf_model.predict(X_test)

#     joblib.dump(rf_model,RANDOMFOREST_MODEL_PATH)

#     return rf_model