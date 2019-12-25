#!/bin/bash

function main {
    #'system_update'         'Perform system updates' 
    update_system

    #'install_drivers'       'Install Drivers like Gprahics' 
    nvidia_430

    #'install_docker'        'Install Docker' 
    docker_install
    nvidia_docker_install

    #'install_cuda'          'Install CUDA' \
    add_cuda_ml_repo
    cuda10_install

    #'install_favs'          'Install preferred applications' \
    #'install_favs_dev'      'Install preferred development tools' \
    #'install_favs_utils'    'Install preferred utilities' \
    #'install_gnome'         'Install preferred GNOME software' \
    #'install_codecs'        'Install multimedia codecs' \
    #'install_fonts'         'Install additional fonts' \
    #'install_snap_apps'     'Install Snap applications' \
    #'install_flatpak_apps'  'Install Flatpak applications' \
    #'install_thirdparty'    'Install third-party applications' \
    import_apps_functions
    install_vscode
    #'setup_dotfiles'        'Configure dotfiles' \
    #'system_configure'      'Configure system' \
    #'system_cleanup'        'Cleanup the system' \

}

# Import Functions
function import_functions {
	DIR="functions"
	# iterate through the files in the 'functions' folder
	for FUNCTION in $(dirname "$0")/$DIR/*; do
		# skip directories
		if [[ -d $FUNCTION ]]; then
			continue
		# exclude markdown readmes
		elif [[ $FUNCTION == *.md ]]; then
			continue
		elif [[ -f $FUNCTION ]]; then
			# source the function file
			. $FUNCTION
		fi
	done
}

# Import main functions
import_functions
# Welcome message
echo_message welcome "$TITLE"
# Run system checks
system_checks
# main
main

