import streamlit as st
from app.model import read_linear_files
import numpy as np

linear_model, linear_scaler= read_linear_files()

def show_linear():
        st.header('Using Linear Regression')

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
            if None in (indicator_1, indicator_2, indicator_3, indicator_4):
               st.warning("Please fill in all four indicators before predicting.")

            else:
                input_data = np.array([[
                        indicator_3, indicator_2, indicator_1, indicator_4
                    ]])
                input_scale = linear_scaler.transform(input_data)
                prediction = linear_model.predict(input_scale)[0]

                st.success(f"Estimated GLD Value: {prediction[0]:.2f}")

        