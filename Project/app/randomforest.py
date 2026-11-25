import streamlit as st
from app.model import read_rf_files
import numpy as np


rf_model = read_rf_files()

def show_randomforest():
    st.header('Using Random Forest')

    # st.sidebar.header(
    #     'Input Details'
    # )

    # st.markdown('##### Enter four Market Indicators:')

    # st.markdown('###### SLV')
    # st.number_input('hidden label1', label_visibility='collapsed')

    # st.markdown('###### USO')
    # st.number_input('hidden label2', label_visibility='collapsed')

    # st.markdown('###### SPX')
    # st.number_input('hidden label3', label_visibility='collapsed')

    # st.markdown('###### EUR/USD')
    # st.number_input('hidden label4', label_visibility='collapsed')

    st.markdown(
        """
        <style>
            [data-testid="stNumberInputStepDown"],
            [data-testid="stNumberInputStepUp"] {
                display: none;
            }
        </style>
        """,
        unsafe_allow_html=True,
    )

    # Creating Column and Row

    r1_c1, r1_c2 = st.columns(2)

    with r1_c1:
        st.markdown('###### SLV')
        indicator_1=st.number_input('hidden label1',value=None, step=None, placeholder='Enter SPX value', label_visibility='collapsed',key='ind_1')

    with r1_c2:
        st.markdown('###### USO')
        indicator_2=st.number_input('hidden label2',value=None, step=None, placeholder='Enter USO value', label_visibility='collapsed',key='ind_2')

    r2_c1, r2_c2 = st.columns(2)

    with r2_c1:
        st.markdown('###### SPX')
        indicator_3=st.number_input('hidden label3',value=None, step=None, placeholder='Enter SLV value', label_visibility='collapsed',key='ind_3')

    with r2_c2:
        st.markdown('###### EUR/USD')
        indicator_4=st.number_input('hidden label4',value=None, step=None, placeholder='Enter EUR/USD value', label_visibility='collapsed',key='ind_4')



    if st.button('Predict',type='primary'):
        input_data = np.array([[
                indicator_3, indicator_2, indicator_1, indicator_4
            ]])
        prediction = rf_model.predict(input_data)[0]

        st.success(f"Estimated GLD Value: key={prediction:.2f}")
