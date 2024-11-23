## use the official python3.9 image
FROM python:3.9-slim

## set the working directory
WORKDIR /code

## copy the dependencies file to the working directory (in container /code)
COPY ./requirements.txt /code/requirements.txt

## install the dependencies
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Setup a new use to avoid root
RUN useradd user

# Switch to the "user" user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set the working home directory to user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app
COPY --chown=user . $HOME/app

# Start fast api app on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]