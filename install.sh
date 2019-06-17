#!/bin/bash

# This script is executed on the virtual machine during the Installation phase.
# It is used to record a predefined VM-image of the appliance.
# Otherwise executed first during a cloud deployement in IFB-Biosphere

LOCUSER='ubuntu'
IRSOM_DIR=/home/${LOCUSER}/IRSOM
source /etc/profile

# Install deps
apt-get update
apt-get install sysstat gnuplot eog  gthumb  imagemagick openjdk-8-jdk emacs gedit  gedit-plugins   gedit-developer-plugins ruby tree ncdu lzop lbzip2 pigz unzip libboost-dev cmake

# Install IRSOM and deps
git clone https://forge.ibisc.univ-evry.fr/lplaton/IRSOM.git ${IRSOM_DIR}
chown -R  ${LOCUSER} ${IRSOM_DIR}
python3 -m pip install -r ${IRSOM_DIR}/pip_package.txt

# Install Tools (w/ conda)
conda install bcftools bedtools  bwa canvas fastqc gatk4 igv lumpy-sv manta picard samtools snpeff snpsift tabix
