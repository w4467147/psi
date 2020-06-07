package io.finer.erp.jeecg.stock.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.finer.erp.jeecg.bas.entity.BasMaterial;
import io.finer.erp.jeecg.bas.entity.BasMeasureUnit;
import io.finer.erp.jeecg.bas.service.IBasMaterialCategoryService;
import io.finer.erp.jeecg.bas.service.IBasMaterialService;
import io.finer.erp.jeecg.bas.service.IBasMeasureUnitService;
import io.finer.erp.jeecg.stock.entity.StkInventory;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.mapper.StkInventoryMapper;
import io.finer.erp.jeecg.stock.service.IStkInventoryService;
import org.jeecg.common.exception.JeecgBootException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Description: 库存
 * @Author: jeecg-boot
 * @Date:   2020-04-11
 * @Version: V1.0
 */
@Service
public class StkInventoryServiceImpl extends ServiceImpl<StkInventoryMapper, StkInventory> implements IStkInventoryService {
    @Autowired
    StkInventoryMapper stkInventoryMapper;
    @Autowired
    IBasMaterialService basMaterialService;
    @Autowired
    IBasMeasureUnitService basMeasureUnitService;

    @Override
    @Transactional
    public void increase(StkIoBillEntry stkIoBillEntry) {
        StkInventory inv_new = new StkInventory();
        inv_new.setWarehouseId(stkIoBillEntry.getWarehouseId());
        inv_new.setMaterialId(stkIoBillEntry.getMaterialId());
        inv_new.setBatchNo(stkIoBillEntry.getBatchNo());

        QueryWrapper<StkInventory> queryWrapper = new QueryWrapper<StkInventory>(inv_new);
        StkInventory inv = stkInventoryMapper.selectOne(queryWrapper);
        String supplierId = stkIoBillEntry.getSupplierId();
        if (inv == null) {
            BasMaterial basMaterial = basMaterialService.getById(stkIoBillEntry.getMaterialId());
            if (basMaterial == null) {
                throw new JeecgBootException(String.format("【分录号：%s】物料在物料表中不存在！",
                        stkIoBillEntry.getEntryNo()));
            }

            inv_new.setUnitId(stkIoBillEntry.getUnitId());
            if (stkIoBillEntry.getBatchNo().equals("0") || supplierId == null || supplierId.isEmpty()) {
                inv_new.setIsSingleSupplier(0);
            }
            else {
                inv_new.setIsSingleSupplier(1);
            }
            inv_new.setSupplierId(supplierId);

            if (stkIoBillEntry.getUnitId().equals(basMaterial.getUnitId())) {
                inv_new.setQty(stkIoBillEntry.getQty());
            } else {
                BigDecimal rate = basMeasureUnitService.getRate(basMaterial.getUnitId(),
                        stkIoBillEntry.getUnitId());
                inv_new.setUnitId(basMaterial.getUnitId());
                inv_new.setQty(stkIoBillEntry.getQty().multiply(rate));
            }

            inv_new.setCost(stkIoBillEntry.getCost());
            stkInventoryMapper.insert(inv_new);
        } else {
            if (inv.getIsSingleSupplier() == 1 && !inv.getSupplierId().equals(supplierId)) {
                throw new JeecgBootException(String.format("【分录号：%s】供应商与实时库存中“仓库+物料+批次号”的供应商不同！",
                        stkIoBillEntry.getEntryNo()));
            }

            if (supplierId != null && !supplierId.isEmpty()) {
                inv.setSupplierId(supplierId); //保存该批次最后一次入库的供应商
            }

            if (stkIoBillEntry.getUnitId().equals(inv.getUnitId())) {
                inv.setQty(inv.getQty().add(stkIoBillEntry.getQty()));
            }
            else {
                BigDecimal rate = basMeasureUnitService.getRate(inv.getUnitId(),
                        stkIoBillEntry.getUnitId());
                inv.setQty(inv.getQty().add(stkIoBillEntry.getQty().multiply(rate)));
            }
            if (inv.getQty().compareTo(BigDecimal.ZERO) < 0) {
                throw new JeecgBootException(String.format("【分录号：%s】“仓库+物料+批次号”的库存数不足！",
                        stkIoBillEntry.getEntryNo()));
            }

            inv.setCost(inv.getCost().add(stkIoBillEntry.getCost()));
            stkInventoryMapper.updateById(inv);
        }
    }

    @Override
    @Transactional
    public void decrease(StkIoBillEntry stkIoBillEntry) {
        StkInventory inv_new = new StkInventory();
        inv_new.setWarehouseId(stkIoBillEntry.getWarehouseId());
        inv_new.setMaterialId(stkIoBillEntry.getMaterialId());
        inv_new.setBatchNo(stkIoBillEntry.getBatchNo());

        QueryWrapper<StkInventory> queryWrapper = new QueryWrapper<StkInventory>(inv_new);
        StkInventory inv = stkInventoryMapper.selectOne(queryWrapper);
        if (inv == null) {
            throw new JeecgBootException(String.format("【分录号：%s】“仓库+物料+批次号”在实时库存中不存在！",
                    stkIoBillEntry.getEntryNo()));
        }
        if (stkIoBillEntry.getUnitId().equals(inv.getUnitId())) {
            inv.setQty(inv.getQty().subtract(stkIoBillEntry.getQty()));
        }
        else {
            BigDecimal rate = basMeasureUnitService.getRate(inv.getUnitId(),
                    stkIoBillEntry.getUnitId());
            inv.setQty(inv.getQty().subtract(stkIoBillEntry.getQty().multiply(rate)));
        }
        if (inv.getQty().compareTo(BigDecimal.ZERO) < 0) {
            throw new JeecgBootException(String.format("【分录号：%s】“仓库+物料+批次号”的库存数不足！",
                    stkIoBillEntry.getEntryNo()));
        }

        inv.setCost(inv.getCost().subtract(stkIoBillEntry.getCost()));
        stkInventoryMapper.updateById(inv);
    }

    @Override
    @Transactional
    public void changeCost(StkIoBillEntry stkIoBillEntry) {
        StkInventory inv_new = new StkInventory();
        inv_new.setWarehouseId(stkIoBillEntry.getWarehouseId());
        inv_new.setMaterialId(stkIoBillEntry.getMaterialId());
        inv_new.setBatchNo(stkIoBillEntry.getBatchNo());

        QueryWrapper<StkInventory> queryWrapper = new QueryWrapper<StkInventory>(inv_new);
        StkInventory inv = stkInventoryMapper.selectOne(queryWrapper);
        if (inv == null) {
            throw new JeecgBootException(String.format("【分录号：%s】“仓库+物料+批次号”在实时库存中不存在！",
                    stkIoBillEntry.getEntryNo()));
        }

        BigDecimal cost = inv.getCost().add(stkIoBillEntry.getCost());
        if (cost.compareTo(BigDecimal.ZERO) < 0) {
            throw new JeecgBootException(String.format("【分录号：%s】“仓库+物料+批次号”调整后成本不能为负！",
                    stkIoBillEntry.getEntryNo()));
        }

        inv.setCost(cost);
        stkInventoryMapper.updateById(inv);
    }

    @Override
    public StkInventory getByBatchNoAndX(String batchNo, String materialId, String warehouseId) {
        StkInventory inv = new StkInventory();
        inv.setBatchNo(batchNo);
        inv.setMaterialId(materialId);
        inv.setWarehouseId(warehouseId);
        QueryWrapper<StkInventory> queryWrapper = new QueryWrapper<StkInventory>(inv);
        return stkInventoryMapper.selectOne(queryWrapper);
    }

}
