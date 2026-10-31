import streamlit as st
from model import gemini

st.header(
    'Gemini Integration LLM'
)

st.subheader(
    'Version gemini-3.8-flash'
)

## Text Placeholder
# st.text_input(
#     'Enter your Prompt',
#     value= 'Explain about animal.',
#     placeholder='Enter your name',
#     max_chars= 40,
#     type='default'
# )


prompt=st.text_area(
    'Enter your Prompt',
    placeholder='Enter your name',

)

## Button
btn = st.button('Send Prompt✈️')

if btn:
    if prompt.strip()=='':
        st.warning('text field cannot be empty.')
    else:
        with st.spinner('Generating Content...'):
            answer= gemini(prompt)
            st.write(answer)
            st.toast('Content Generated')
            
