package io.finer.erp.jeecg.finance.controller;

import io.finer.erp.jeecg.finance.service.IFinCarryForwardService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags="财务结转")
@RestController
@RequestMapping("/finance/carryForward")
@Slf4j
public class FinCarryForwardController {
    @Autowired
    IFinCarryForwardService finCarryForwardService;

    @AutoLog(value = "月末结转")
    @ApiOperation(value="月末结转", notes="月末结转")
    @PostMapping(value = "/month")
    public Result<?> monthCarryForward(@RequestParam(name="year",required=true) Integer year,
                                       @RequestParam(name="month",required=true) Integer month) {
        finCarryForwardService.monthCarryForward(year, month);
        return Result.ok("月末结转成功！");
    }

}
