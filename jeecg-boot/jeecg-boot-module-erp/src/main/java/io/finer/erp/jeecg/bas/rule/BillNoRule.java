package io.finer.erp.jeecg.bas.rule;

import com.alibaba.fastjson.JSONObject;
import io.finer.erp.jeecg.bas.entity.BasSequence;
import io.finer.erp.jeecg.bas.service.IBasSequenceService;
import org.jeecg.common.handler.IFillRuleHandler;
import org.jeecg.common.util.SpringContextUtils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BillNoRule implements IFillRuleHandler {
    @Override
    public Object execute(JSONObject params, JSONObject formData) {
        String prefix = "", period = "";
        Integer seqLen = 0;
        if (params != null) {
            Object obj = params.get("prefix");
            if (obj != null) prefix = obj.toString();

            obj = params.get("period");
            if (obj != null) period = obj.toString();

            obj = params.get("seqLen");
            if (obj != null) seqLen = Integer.parseInt(obj.toString());
        }

        SimpleDateFormat format = new SimpleDateFormat(period);
        String k = prefix + format.format(new Date());
        if (k == null || k.length() == 0) {
            return null;
        }

        int seq = 1;
        IBasSequenceService basSequenceService = (IBasSequenceService) SpringContextUtils.getBean("basSequenceServiceImpl");
        BasSequence basSequence = basSequenceService.getById(k);
        if (basSequence == null) {
            basSequence = new BasSequence();
            basSequence.setK(k);
            basSequence.setV(1);
            basSequenceService.save(basSequence);
        } else {
            seq = basSequence.getV() + 1;
            basSequence.setV(seq);
            basSequenceService.updateById(basSequence);
        }

        return k + String.format("%0" + seqLen + "d", seq);
    }
}