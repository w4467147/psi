package io.finer.erp.jeecg.bas.service.impl;

import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.bas.entity.BasMeasureUnit;
import io.finer.erp.jeecg.bas.mapper.BasMeasureUnitMapper;
import io.finer.erp.jeecg.bas.service.IBasMeasureUnitService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.math.BigDecimal;

/**
 * @Description: 计量单位
 * @Author: jeecg-boot
 * @Date:   2020-03-27
 * @Version: V1.0
 */
@Service
public class BasMeasureUnitServiceImpl extends ServiceImpl<BasMeasureUnitMapper, BasMeasureUnit> implements IBasMeasureUnitService {

	@Override
	public void addBasMeasureUnit(BasMeasureUnit basMeasureUnit) {
		if(oConvertUtils.isEmpty(basMeasureUnit.getPid())){
			basMeasureUnit.setPid(IBasMeasureUnitService.ROOT_PID_VALUE);
		}else{
			//如果当前节点父ID不为空 则设置父节点的hasChildren 为1
			BasMeasureUnit parent = baseMapper.selectById(basMeasureUnit.getPid());
			if(parent!=null && !"1".equals(parent.getHasChild())){
				parent.setHasChild("1");
				baseMapper.updateById(parent);
			}
		}
		baseMapper.insert(basMeasureUnit);
	}
	
	@Override
	public void updateBasMeasureUnit(BasMeasureUnit basMeasureUnit) {
		BasMeasureUnit entity = this.getById(basMeasureUnit.getId());
		if(entity==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		String old_pid = entity.getPid();
		String new_pid = basMeasureUnit.getPid();
		if(!old_pid.equals(new_pid)) {
			updateOldParentNode(old_pid);
			if(oConvertUtils.isEmpty(new_pid)){
				basMeasureUnit.setPid(IBasMeasureUnitService.ROOT_PID_VALUE);
			}
			if(!IBasMeasureUnitService.ROOT_PID_VALUE.equals(basMeasureUnit.getPid())) {
				baseMapper.updateTreeNodeStatus(basMeasureUnit.getPid(), IBasMeasureUnitService.HASCHILD);
			}
		}
		baseMapper.updateById(basMeasureUnit);
	}
	
	@Override
	public void deleteBasMeasureUnit(String id) throws JeecgBootException {
		BasMeasureUnit basMeasureUnit = this.getById(id);
		if(basMeasureUnit==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		updateOldParentNode(basMeasureUnit.getPid());
		baseMapper.deleteById(id);
	}

	@Override
	public BigDecimal getRate(String toId, String fromId) {
		//cfm:
		BasMeasureUnit from = baseMapper.selectById(fromId);
		BasMeasureUnit to = baseMapper.selectById(toId);
		if (from == null || to == null) {
			throw new JeecgBootException(String.format("【ID：%s】计量单位不存在！",
					from == null ? fromId : toId));
		}

		String fromPid = from.getPid().equals("0") ? from.getId() : from.getPid();
		String toPid = to.getPid().equals("0") ? to.getId() : to.getPid();
		if (!fromPid.equals(toPid)) {
			throw new JeecgBootException(String.format("【%s，%s】基准单位不同，不能转换！",
					from.getName(), to.getName()));
		}

		return from.getFactor().divide(to.getFactor());
	}


	/**
	 * 根据所传pid查询旧的父级节点的子节点并修改相应状态值
	 * @param pid
	 */
	private void updateOldParentNode(String pid) {
		if(!IBasMeasureUnitService.ROOT_PID_VALUE.equals(pid)) {
			Integer count = baseMapper.selectCount(new QueryWrapper<BasMeasureUnit>().eq("pid", pid));
			if(count==null || count<=1) {
				baseMapper.updateTreeNodeStatus(pid, IBasMeasureUnitService.NOCHILD);
			}
		}
	}

}
