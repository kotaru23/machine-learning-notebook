FROM kotaru/gpu-base-notebook:latest

# install Python library for machine learning
# Enable multi-gpu xgboost
RUN wget https://s3-us-west-2.amazonaws.com/xgboost-wheels/xgboost-0.81-py2.py3-none-manylinux1_x86_64.whl && \
    pip3 --no-cache-dir install --upgrade pip && \
    pip3 --no-cache-dir install \
        numpy \
        scipy \
        pandas \
        h5py \
        joblib \
        cupy \
        scikit-learn \
        imbalanced-learn \
        nose \
        tensorflow-gpu \
        keras \
        seaborn \
        matplotlib \
        plotly \
        jupyter \ 
        yapf \
        tqdm \
        cython \
        jupyter_contrib_nbextensions \
        bayesian-optimization \
        pydot \
        graphviz \
        pydot3 \
        pydot-ng \
        pillow \
        folium \
        autopep8 \
        line_profiler \
        memory_profiler \
        rise \
        xgboost-0.81-py2.py3-none-manylinux1_x86_64.whl

# Jupyter NotebookのExtensionの設定
RUN jupyter contrib nbextension install --user && \
    : "Jupyter NotebookのキーバインドをVim風に設定" && \
    mkdir -p $(jupyter --data-dir)/nbextensions && \
    cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding &&  \
    jupyter nbextension enable vim_binding/vim_binding && \
    : "Jupyter Notebookでプレゼンをするためのライブラリ" && \
    jupyter-nbextension install rise --py --sys-prefix && \
    jupyter-nbextension enable rise --py --sys-prefix && \
    : "セルごとに実行時間を測定" && \
    jupyter-nbextension enable execute_time/ExecuteTime  && \
    jupyter nbextension enable move_selected_cells/main && \
    jupyter nbextension enable toggle_all_line_numbers/main && \
    jupyter nbextension enable code_prettify/code_prettify && \
    jupyter nbextension enable scratchpad/main

WORKDIR /notebooks
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
