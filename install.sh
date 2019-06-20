#!/bin/bash

# This script is executed on the virtual machine during the Installation phase (need to be ran as root!).
# It is used to record a predefined VM-image of the appliance.
# Otherwise executed first during a cloud deployement in IFB-Biosphere

LOCUSER='ubuntu'
LOCUSER_HOME=`eval echo "~$LOCUSER"`
IRSOM_DIR=${LOCUSER_HOME}/IRSOM
source /etc/profile

# Install deps
apt-get update
apt-get install sysstat gnuplot eog  gthumb  imagemagick openjdk-8-jdk emacs gedit  gedit-plugins   gedit-developer-plugins ruby tree ncdu lzop lbzip2 pigz unzip libboost-dev cmake

# Install IRSOM and deps
git clone https://forge.ibisc.univ-evry.fr/lplaton/IRSOM.git ${IRSOM_DIR}
chown -R  ${LOCUSER} ${IRSOM_DIR}
python3 -m pip install -r ${IRSOM_DIR}/pip_package.txt

# Install Tools (w/ conda)
conda install bcftools bedtools bwa fastqc gatk4 igv lumpy-sv manta picard samtools snpeff snpsift tabix

# Install Canvas (Require .Net)
curl -O https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

add-apt-repository universe
apt-get install -y apt-transport-https
apt-get update
apt-get install -y aspnetcore-runtime-2.1

cd ${LOCUSER_HOME}
curl -LJO https://github.com/Illumina/canvas/releases/download/1.40.0.1613%2Bmaster/Canvas-1.40.0.1613.master_x64.tar.gz
tar -xzvf Canvas-1.40.0.1613.master_x64.tar.gz
rm -r 1.40.0.1613+master/
rm Canvas-1.40.0.1613.master_x64.tar.gz
chown -R ${LOCUSER} Canvas-1.40.0.1613+master_x64
# run it from LOCUSER's homedir with dotnet Canvas-1.40.0.1613+master_x64/Canvas.dll
