# terraform-stack

練習使用 Terraform 建立一個完整有 Private GKE Cluster 的專案。

## 注意事項

- 先建立一個 Cluster，再裝 helmfile-stack 的 ingress 以建立 NEG
- 使用最新版的 provider
- 請為每個 Namespace 建立對應的 Node Pool，並且賦予 Label/Taint
- GKE 的 Spec & Node Pool 請參考 fingergame monitoring 的 cluster, Node Pool 不要包跨有 `midtown` 的 pool
- 所有的 IP 都要用 data 來獲取
- 使用 variable 讓這個模板可以在之後在別的專案被那來共用
- 使用 GCS 儲存 terraform 的 state (Bucket Name: `sre-practice-888-tfstates`, Prefix: `armageddon-patrick`)
- 請為 NAT 和 LB 設定固定 IP, 並在 apply 的時候顯示 output
- 說明怎麼檢查是否 NAT 的 IP 是正確的
- LB 要加 domain name `patrick.crow.idv.tw`, 建立完 LB 要跟大鳥說 IP 是什麼 ，有空再加 HTTPS

:warning: **下班前記得把 Cluster 關掉！下班前記得把 Cluster 關掉！下班前記得把 Cluster 關掉！**

## 代辦事項
- [x] 請列出 Terraform 的 Service Account 所需要使用到的 Role，並且加到 terraform publisher 裡面
- [x] GKE
- [x] NAT
- [x] LB

## 當前進度

#### 1. Terraform - Service Account & Role

Terraform 的 Service Account 所需要使用到的 Role： 

- **compute.loadBalancerAdmin**: 創建、修改和刪除負載均衡器及相關資源
- **compute.networkAdmin**: 創建、修改和刪除網路資源 (不包括防火牆規則和 SSL 證書)
- **compute.securityAdmin**: 創建、修改和刪除防火牆規則和 SSL 證書，配置 Shielded VM
- **container.admin**: 完整管理 K8s 集群和 K8s API 對象 (Pod、Deployment、ConfigMap...等等)
- **iam.serviceAccountUser**: 使用 serviceAccount (不包括創建、修改和刪除 serviceAccount)
- **monitoring.alertPolicyEditor**: 讀寫 alertPolicy
- **monitoring.notificationChannelViewer**: 讀取 notificationChannel
- **storage.admin**: 完整管理儲存體(bucket)和儲存對象(object)

上述的 Role 皆已加入 sre-practice 專案的 terraform publisher 當中，詳情可用以下指令查看：

```bash
gcloud config set project sre-practice-888
gcloud projects get-iam-policy sre-practice-888  \
--flatten="bindings[].members" \
--format='table(bindings.role)' \
--filter="bindings.members:serviceAccount:terraform-publisher@sre-practice-888.iam.gserviceaccount.com"
```


#### 2. GKE, NAT 和 LB 服務皆可以透過 Terraform 正常佈署


#### 3. 檢查 NAT 的 IP 設定有正確生效的方法

- 在 GKE Cluster 佈署實驗用的 deployment (例如：nginx) 再進入 pod 下指令：`curl ifconfig.me`，看回傳的 IP 位址是否和 NAT 的 IP 位址一樣


#### 4. 注意事項 - 完成紀錄(2023/06/15)

- [x] 先建立一個 Cluster，再裝 helmfile-stack 的 ingress 以建立 NEG
- [x] 使用最新版的 provider
- [x] 請為每個 Namespace 建立對應的 Node Pool，並且賦予 Label/Taint
- [x] GKE 的 Spec & Node Pool 請參考 fingergame monitoring 的 cluster, Node Pool 不要包跨有 `midtown` 的 pool
- [x] 所有的 IP 都要用 data 來獲取
- [x] 使用 variable 讓這個模板可以在之後在別的專案被那來共用
- [x] 使用 GCS 儲存 terraform 的 state (Bucket Name: `sre-practice-888-tfstates`, Prefix: `armageddon-patrick`)
- [x] 請為 NAT 和 LB 設定固定 IP, 並在 apply 的時候顯示 output
- [x] 說明怎麼檢查是否 NAT 的 IP 是正確的
- [x] LB 要加 domain name `patrick.crow.idv.tw`, 建立完 LB 要跟大鳥說 IP 是什麼 ，有空再加 HTTPS
