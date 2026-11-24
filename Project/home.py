import streamlit as st


st.set_page_config(
    page_title= 'GOLD Estimation',
    page_icon= '🪙',
    layout='centered'
)

def Home():
    st.Page('home.py', title= 'Home')
    st.header('Home Page')

pages= {
    "Home":{
        st.Page(Home)
    },

    "Models":{
        st.Page("app/linear.py", title='Linear'),
        st.Page("app/randomforest.py", title='RandomForest')
    }
}

pg= st.navigation(pages, position='top')
pg.run()