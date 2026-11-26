import streamlit as st
from app.linear import show_linear
from app.randomforest import show_randomforest


st.set_page_config(
    page_title= 'GOLD Value Prediction',
    layout='centered'
)

# st.header('Gold Value Estimation')

def home():
    st.header('Gold Value Prediction')

    if 'selected_model' not in st.session_state:
        st.session_state.selected_model = None

    # Placing models sidebyside
    
    col1,col2=st.columns(2)

    with col1:
        st.subheader("Linear Regression")
        if st.button("Open Linear Regression",key='linear'):
            st.session_state.selected_model = 'linear'

    with col2:
        st.subheader("Random Forest")
        if st.button("Open Random Forest", key='randomforest'):
            st.session_state.selected_model = 'randomforest'    

    st.divider()

    if st.session_state.selected_model == 'linear':
        show_linear()
    elif st.session_state.selected_model == 'randomforest':
        show_randomforest()

# st.header('Home Page')
  

Home = st.Page(home, title='Gold Value Prediction', default=True)

linear = st.Page("app/linear.py", title="Linear Regression")
rf = st.Page("app/randomforest.py", title="Random Forest")

pg = st.navigation([ Home, linear, rf], position='hidden')


pg.run()