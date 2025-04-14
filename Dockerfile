FROM python:3.13.3-alpine3.20
LABEL maintainer="Prabhat Ranjan Mahanty"

# prevents python from buffering our output. this below line is required when python is running in a container
# the output from python will be printed directly to the terminal which prevents any delays(buffering) of
# messages getting from python to the terminal
ENV PYTHONUNBUFFERED=1

# copy local requirements.txt to container under tmp folder
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
# copy local app to container under app folder
COPY ./app /app
# copy local entrypoint.sh to container under entrypoint.sh
WORKDIR /app

EXPOSE 8000

ARG DEV=false
# this below code helps to install python dependencies in a container and building the image in one go
# this first line creates a virtual environment in the container which stores python dependencies
RUN python -m venv /py && \
# this installs the python upgrade manager inside our virtual environment
    /py/bin/pip install --upgrade pip && \
    # this installs the list of requirements inside our virtual environment or docker image
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    # this removes the temporary folder means once the image is built it will be deleted. no need extra dependencies. Keep the docker images as lightweight as possible
    rm -rf /tmp && \
    # this creates a user inside the container. Its not best practice to use root user.
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# this is to set the environment variable for the virtual environment or docker image
# it defines all the directories that are available inside the container where executables can be run
# So, when a command runs in project, we should not specify the full path. /py/bin/path every time.
# istead we can just write path    
ENV PATH="/py/bin:$PATH"

USER django-user