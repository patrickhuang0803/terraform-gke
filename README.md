# terraform-stack

本專案為使用 [Terraform](https://www.terraform.io/) 建立具備 **Private GKE Cluster** 架構的基礎設施模板，涵蓋 GKE、NAT、負載平衡器（Load Balancer）等元件，並支援多命名空間對應 Node Pool 的部署策略。所有狀態均透過 GCS 儲存，設計目標為可於多專案中重複使用。

---

## 架構概述

- 私有 GKE 叢集
- 每個 Namespace 對應獨立 Node Pool（具備 Taint/Label）
- 使用 Helmfile 部署 Ingress（建立 NEG）
- 支援自定義 NAT、L7 Load Balancer（含固定 IP 與自訂網域）
- 使用 Terraform Module 與變數進行可重用設計
- State 儲存於 GCS（Bucket: `sre-practice-888-tfstates`, Prefix: `armageddon-patrick`）

---

## 使用前注意事項

- GKE Cluster 應先建置，再執行 Helmfile 安裝 ingress，用於建立 NEG。
- 請務必使用最新版 Google Terraform Provider。
- 每個命名空間需對應獨立 Node Pool，並設定合適的 Label/Taint。
- 所有 IP 須透過 `data` 來源取得，不得硬編碼。
- GKE Cluster 及 Node Pool 請參考 fingergame monitoring 專案設定，不應包含名稱中帶有 `midtown` 的 Pool。
- NAT 和 Load Balancer 須使用預先保留的靜態 IP，並於 Terraform Output 中明確顯示。
- Load Balancer 須綁定網域 `patrick.crow.idv.tw`，部署完成後請回報 IP 以設定 DNS。
- NAT IP 驗證方式請參閱下方說明。

> ⚠ **請務必於下班前關閉 GKE Cluster，以避免產生額外費用。**

---

## Terraform 基礎設置

### Service Account 權限需求

Terraform 使用的 Service Account 須具備以下 IAM 角色：

| Role | 說明 |
|------|------|
| `roles/compute.loadBalancerAdmin` | 管理負載平衡器 |
| `roles/compute.networkAdmin` | 管理 VPC 網路 |
| `roles/compute.securityAdmin` | 管理防火牆與 SSL |
| `roles/container.admin` | 管理 Kubernetes 叢集 |
| `roles/iam.serviceAccountUser` | 允許切換 Service Account 身份 |
| `roles/monitoring.alertPolicyEditor` | 設定告警策略 |
| `roles/monitoring.notificationChannelViewer` | 檢視通知通道 |
| `roles/storage.admin` | 管理 GCS Bucket 與物件 |

可使用以下指令查詢 IAM 權限：

```bash
gcloud config set project sre-practice-888
gcloud projects get-iam-policy sre-practice-888  --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:serviceAccount:terraform-publisher@sre-practice-888.iam.gserviceaccount.com"
```

---

## 功能進度與驗證

### ✅ 基礎資源部署完成

- GKE Cluster 可透過 Terraform 正常建置
- NAT Gateway 與 Load Balancer 可自動部署並綁定固定 IP
- 已配置 Helmfile 部署 Ingress 並正確建立 NEG

### ✅ NAT IP 驗證方式

1. 在 GKE 部署一個測試 Pod，例如 nginx：

   ```bash
   kubectl run test-nginx --image=nginx -n default --restart=Never -it --rm -- bash
   ```

2. 在 Pod 中執行：

   ```bash
   curl ifconfig.me
   ```

3. 確認回傳 IP 是否為 NAT 的固定 IP

---

## 網域與 Load Balancer 設定

- Load Balancer 綁定網域名稱：`patrick.crow.idv.tw`
- 部署完成後，請通知 DNS 管理員更新 A Record 至 LB 公網 IP
- 後續可視需求加入 HTTPS 支援（建議使用 Let's Encrypt）

---

## 專案狀態儲存

- Terraform State 儲存於 GCS：
  - Bucket: `sre-practice-888-tfstates`
  - Prefix: `armageddon-patrick`

請確認具備 `roles/storage.admin` 權限以便讀寫該 Bucket。

---

## 附註

- 本模板支援以變數方式靈活配置命名空間、節點池 Label/Taint 與其他參數，適合擴展至其他專案使用。
- 若有修改 GKE 或 Terraform Provider，請優先測試再合併主分支。

> 📌 **安全提醒：請於每日工作結束前手動銷毀 GKE Cluster，以避免資源空轉與額外費用。**

---

## 聯絡資訊

如需協助或有建議，請聯繫專案維護者：  
📧 patrick830803@gmail.com