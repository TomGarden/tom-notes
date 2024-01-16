



## 0x01. 由问题引入需求

我们考虑 docker container 编排管理工具 , 是出于实际的需求 . 
- 我们期望我们的 容器有 固定的 ip 从而方便容器间的信息交互 . 
- 我们认为通过命令的方式设定固定 ip 的维护成本较高 , 操作也趋于复杂了 . 

要实现固定 ip 已知的方式是 : 
```
# 创建自定义网络
docker network create --subnet=172.18.0.0/16 mynetwork
# 运行容器并连接到自定义网络，指定 IP 地址
docker run --network=mynetwork --ip=172.18.0.2 -d my_image
```


## 0x02. 为什么选定 docker compose (From ChatGPT)

在选择适合你生产环境的Docker容器管理工具时，可以考虑以下优缺点和使用建议：

1. **Docker Compose:**
   - 优点：
     - 简单易用，适合小规模应用的快速部署。
     - 与Docker原生集成，无需额外安装。
   - 缺点：
     - 不适用于大规模复杂应用的编排和管理。
     - 缺乏一些高级容错和自动化功能。
   - 使用建议：
     - 适用于小型项目和开发环境，或者对于简单的容器组合。

2. **Kubernetes (K8s):**
   - 优点：
     - 适用于大规模和复杂应用的容器编排和管理。
     - 强大的生态系统，支持高可用性、自动扩展、滚动更新等特性。
   - 缺点：
     - 学习曲线较陡峭，对于小规模项目可能过于复杂。
     - 需要额外的资源和配置。
   - 使用建议：
     - 适用于大规模、复杂的生产环境，有专业的运维团队。

3. **Rancher:**
   - 优点：
     - 提供图形用户界面，简化了Docker和Kubernetes的管理。
     - 支持多云环境和本地部署。
   - 缺点：
     - 可能会在性能上略有损失，相对于直接使用原生Docker或Kubernetes。
   - 使用建议：
     - 适用于需要更容易入门的Docker和Kubernetes管理平台，但仍然需要一定的可扩展性。

4. **Portainer:**
   - 优点：
     - 提供直观的图形化用户界面，方便使用和理解。
     - 适用于简单的容器管理需求。
   - 缺点：
     - 功能相对较为简化，不适用于复杂的容器编排。
   - 使用建议：
     - 适用于小型项目或初学者，需要轻松快速地管理Docker容器。

5. **Docker Swarm:**
   - 优点：
     - Docker原生支持，易于安装和使用。
     - 相对较轻量，适用于小型到中等规模的集群。
   - 缺点：
     - 功能相对较为简化，不如Kubernetes灵活。
   - 使用建议：
     - 适用于小型到中等规模项目，对Kubernetes感到过于复杂的情况。

在做最终选择之前，建议在测试环境中使用候选工具进行验证，以确保其符合你的预期和需求。此外，考虑你的团队技能和熟悉度，以便更轻松地集成和维护所选的工具。


## 0x03. [docker compose 概述](https://docs.docker.com/compose/)

通过 docker compose 使用和管理多个 docker container , 能够避免一些重复的工作 . 

## 0x04. 安装 docker compose

- 对于桌面环境 直接 安装 docker desktop 即可
- 对于服务端环境 需要 安装 Docker Engine 

如果需要 gui 远程管理可以在探索其他工具

## 0x05. [实际编写 docker compose 文件](https://docs.docker.com/compose/compose-file/)


## 0x06. [docker-compose 指令详解](https://docs.docker.com/compose/reference/)

