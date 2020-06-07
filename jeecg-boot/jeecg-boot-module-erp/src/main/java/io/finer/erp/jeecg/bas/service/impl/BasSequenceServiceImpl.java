package io.finer.erp.jeecg.bas.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.finer.erp.jeecg.bas.entity.BasSequence;
import io.finer.erp.jeecg.bas.mapper.BasSequenceMapper;
import io.finer.erp.jeecg.bas.service.IBasSequenceService;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 * @Description: bas_sequence
 * @Author: jeecg-boot
 * @Date: 2020-03-20
 * @Version: V1.0
 */
@Service
@Component
public class BasSequenceServiceImpl extends ServiceImpl<BasSequenceMapper, BasSequence> implements IBasSequenceService {

}
