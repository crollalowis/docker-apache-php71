#!/bin/bash
	
cd /var/www/html/

# Download Craft CMS by using Craft CLI
# If Craft CMS exists already, the download will be skipped.

# echo "Downloading Craft CMS..."

# craft download --terms --no-prompt

# Run Apache2

apache2-foreground

