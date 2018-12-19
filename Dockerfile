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

WORKDIR /notebooks
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
