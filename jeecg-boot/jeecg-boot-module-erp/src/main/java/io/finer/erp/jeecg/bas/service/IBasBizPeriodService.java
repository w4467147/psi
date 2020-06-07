package io.finer.erp.jeecg.bas.service;

import io.finer.erp.jeecg.bas.entity.BasBizPeriod;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;

/**
 * @Description: bas_biz_period
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
public interface IBasBizPeriodService extends IService<BasBizPeriod> {
    BasBizPeriod getCurrent();
    BasBizPeriod getPrev(BasBizPeriod bizPeriod);
    BasBizPeriod getNext(BasBizPeriod bizPeriod);
    void validateBillDate(Date date);
    void monthCarryForward(Integer year, Integer month);
}
