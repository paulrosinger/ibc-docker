

    Running the new IB Controller (IBCAlpha/IBC) in a Docker container.


    Usage (MacOS):

    1. Edit the user, password and trading mode in configure_user.sh
    2. Install and run Quartz (https://stackoverflow.com/questions/37523980/running-gui-apps-on-docker-container-with-a-macbookpro-host)
    3. Run run_local_setup.ch to configure user settings in the IB Gateway GUI. These will be saved under ./tmp_jts
    4. Run run_local_headless.ch for a headless instance which uses the previously saved user settings
    
    