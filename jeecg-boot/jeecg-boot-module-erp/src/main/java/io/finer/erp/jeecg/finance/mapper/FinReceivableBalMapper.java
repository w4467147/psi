package io.finer.erp.jeecg.finance.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.finer.erp.jeecg.finance.entity.FinReceivableBal;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.mapping.StatementType;

/**
 * @Description: fin_receivable_bal
 * @Author: jeecg-boot
 * @Date:   2020-05-25
 * @Version: V1.0
 */
public interface FinReceivableBalMapper extends BaseMapper<FinReceivableBal> {

    @Update("{call sp_fin_receivable_bal_month_carry_forward(#{year,jdbcType=SMALLINT,mode=IN},#{month,jdbcType=TINYINT,mode=IN})}")
    @Options(statementType = StatementType.CALLABLE)
    void monthCarryForward(Integer year, Integer month);
}
