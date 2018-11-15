# RancherOS Vagrant

This was a fork of an existing rancher repo. 


## Getting started
1.) Install dependencies

* Virtualbox
* Vagrant

2.) Clone this project

```
git clone <project-link>
cd into the git repo
```

3.) Up and Running

```
vagrant up
vagrant ssh rancher-cattle
vagrant ssh rancher-master
```
Navigate to http://172.19.8.100:8080 for the web UI. It is un-authenticated. 

A load balancer is already deployed. 



```
vagrant destroy
```



# License
Copyright (c) 2014-2015 [Rancher Labs, Inc.](http://rancher.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

