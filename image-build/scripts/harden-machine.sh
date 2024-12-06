#!/bin/bash

# install openscap
sudo apt install libopenscap8 -y

# install dependencies
sudo apt install curl zip git -y

# get CIS benchmark
SSG_VERSION=$(git ls-remote --tags --ref --sort v:refname https://github.com/ComplianceAsCode/content.git | grep -Pio '(\d+(\.)){2}[\w\.-][\d+]' | tail -1)
if [ -n "$SSG_VERSION" ]; then
    # Download Most Recent Security Guide
    sudo wget https://github.com/ComplianceAsCode/content/releases/download/v${SSG_VERSION}/scap-security-guide-${SSG_VERSION}.zip -O ssg.zip
    sudo unzip -jo ssg.zip "scap-security-guide-${SSG_VERSION}/*" -d ssg

    # Generate before report
    sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis_level1_server --report ./before-report.html ./ssg/ssg-ubuntu2204-ds.xml

    # Remediate and create after report
    sudo oscap xccdf eval --remediate --profile xccdf_org.ssgproject.content_profile_cis_level1_server --report ./after-report.html ./ssg/ssg-ubuntu2204-ds.xml
fi

# ensure 0 exit code even when some oscap remediations fail
exit 0
