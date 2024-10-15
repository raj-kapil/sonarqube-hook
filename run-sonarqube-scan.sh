#!/bin/sh

# Use environment variables if available, otherwise fallback to defaults
SONAR_PROJECT_KEY=${SONAR_PROJECT_KEY:-"default-project-key"}
# SONAR_ORGANIZATION=${SONAR_ORGANIZATION:-"default-organization"} // in case using self-hosted sonarqube
SONAR_HOST_URL=${SONAR_HOST_URL:-"https://sonarcloud.io"}
SONAR_LOGIN=${SONAR_LOGIN:-"<your-sonarcloud-token>"}

echo "Connecting to sonarqube..."
echo "Project: $SONAR_PROJECT_KEY \n" 
# echo "Org: $SONAR_ORGANIZATION \n" 
echo "Host: $SONAR_HOST_URL \n" 
echo "Token: $SONAR_LOGIN \n" 

echo "Running SonarQube scan before commit..."

mvn clean verify sonar:sonar \
  -Dsonar.projectKey=$SONAR_PROJECT_KEY \
  # -Dsonar.organization=$SONAR_ORGANIZATION \
  -Dsonar.host.url=$SONAR_HOST_URL \
  -Dsonar.login=$SONAR_LOGIN

# Exit with non-zero status if scan fails
if [ $? -ne 0 ]; then
  echo "SonarQube scan failed. Aborting commit."
  exit 1
else
  echo "SonarQube scan passed. Proceeding with commit."
fi
