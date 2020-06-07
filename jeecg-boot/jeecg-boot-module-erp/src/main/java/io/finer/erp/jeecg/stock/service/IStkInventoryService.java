package io.finer.erp.jeecg.stock.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.finer.erp.jeecg.stock.entity.StkInventory;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;

import java.util.List;

/**
 * @Description: 库存
 * @Author: jeecg-boot
 * @Date:   2020-04-11
 * @Version: V1.0
 */
public interface IStkInventoryService extends IService<StkInventory> {
    void increase(StkIoBillEntry stkIoBillEntry);
    void decrease(StkIoBillEntry stkIoBillEntry);
    void changeCost(StkIoBillEntry stkIoBillEntry);
    StkInventory getByBatchNoAndX(String batchNo, String materialId, String warehouseId);
}
