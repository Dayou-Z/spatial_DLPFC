# Human DLPFC Visium 空间转录组分析

本项目基于公开 human DLPFC 10x Visium 数据，分析 sample `151673`。该样本包含人工标注的 Layer1–Layer6 和 white matter（WM），适合用于空间表达模式检查和空间聚类方法比较。

## 完整报告

* [中文报告](https://dayou-z.github.io/spatial_DLPFC/DLPFC_spatial_report_zh.html)
* [English report](https://dayou-z.github.io/spatial_DLPFC/DLPFC_spatial_report_en.html)

## 项目内容

本项目包括：

- spot-level QC 和预处理；
- 使用 Moran’s I 识别空间可变基因；
- 检查已知 marker 的空间表达；
- 比较 Leiden、SpaGCN 和 BayesSpace 聚类结果；
- 使用 Tangram 进行 snRNA-seq 参考映射；
- 进行 neighborhood enrichment、Co-occurrence 和 Ripley’s L 空间邻域分析。

人工层注释只作为 reference label，用于评估聚类结果；不参与无监督聚类过程。

## 主要结果

- QC 后保留 3,601 个 spot 和 16,567 个基因。
- `MBP`、`PLP1`、`MOBP`、`MAG` 等 WM / myelin / oligodendrocyte 相关基因在 Moran’s I 排名中靠前。
- 在本样本和当前参数下，BayesSpace 与人工层注释的一致性最高。

| 方法 | ARI | NMI |
|---|---:|---:|
| Leiden | 0.3882 | 0.5009 |
| SpaGCN | 0.3163 | 0.4593 |
| BayesSpace | 0.5355 | 0.6729 |

Tangram 结果中，`Oligodendrocyte` 的高分区域主要位于 WM，`L2/3 IT` 的高分区域主要位于浅层皮层。

## 目录结构

## 目录结构

```text
.
├── docs/
│   ├── DLPFC_spatial_report_zh.html
│   └── DLPFC_spatial_report_en.html
├── notebooks/
├── qmd/
│   ├── DLPFC_spatial_report_zh.qmd
│   └── DLPFC_spatial_report_en.qmd
├── results/
│   ├── figures/
│   └── tables/
├── scripts/
├── environment.yml
└── README.md
```

## 运行环境

核心软件版本：

| 软件 | 版本 |
|---|---:|
| Python | 3.12.13 |
| R | 4.5.3 |
| Scanpy | 1.12.1 |
| Squidpy | 1.8.1 |
| SpaGCN | 1.2.7 |
| BayesSpace | 1.20.2 |
| Tangram | 1.0.4 |
| scikit-learn | 1.8.0 |

创建环境：

```bash
conda env create -f environment.yml
conda activate spatial
```

## 参考文献

Maynard, K. R., Collado-Torres, L., Weber, L. M., et al. Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex. *Nature Neuroscience* 24, 425–436 (2021).
