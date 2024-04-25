# Troubleshooting IO.NET Mac M1/M2/M3 workers

## MacOS

1. For checking Docker containers please run command in Terminal `docker ps`
  
2. Error loading Python lib
   - Please upgrade your system to Sonoma 14.4.1
  
3. Docker daemon is not rinning. Please start Docker and try againe.
   - colima start
  
4. Error: bad CPU type in executable: ./launch_binary_mac
   - Install Rosetta2 `softwareupdate --install-rosetta`
