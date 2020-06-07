package io.finer.erp.jeecg.bas.service.impl;

import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.bas.entity.BasWarehouse;
import io.finer.erp.jeecg.bas.mapper.BasWarehouseMapper;
import io.finer.erp.jeecg.bas.service.IBasWarehouseService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * @Description: 仓库
 * @Author: jeecg-boot
 * @Date:   2020-04-01
 * @Version: V1.0
 */
@Service
public class BasWarehouseServiceImpl extends ServiceImpl<BasWarehouseMapper, BasWarehouse> implements IBasWarehouseService {

	@Override
	public void addBasWarehouse(BasWarehouse basWarehouse) {
		if(oConvertUtils.isEmpty(basWarehouse.getPid())){
			basWarehouse.setPid(IBasWarehouseService.ROOT_PID_VALUE);
		}else{
			//如果当前节点父ID不为空 则设置父节点的hasChildren 为1
			BasWarehouse parent = baseMapper.selectById(basWarehouse.getPid());
			if(parent!=null && !"1".equals(parent.getHasChild())){
				parent.setHasChild("1");
				baseMapper.updateById(parent);
			}
		}
		baseMapper.insert(basWarehouse);
	}
	
	@Override
	public void updateBasWarehouse(BasWarehouse basWarehouse) {
		BasWarehouse entity = this.getById(basWarehouse.getId());
		if(entity==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		String old_pid = entity.getPid();
		String new_pid = basWarehouse.getPid();
		if(!old_pid.equals(new_pid)) {
			updateOldParentNode(old_pid);
			if(oConvertUtils.isEmpty(new_pid)){
				basWarehouse.setPid(IBasWarehouseService.ROOT_PID_VALUE);
			}
			if(!IBasWarehouseService.ROOT_PID_VALUE.equals(basWarehouse.getPid())) {
				baseMapper.updateTreeNodeStatus(basWarehouse.getPid(), IBasWarehouseService.HASCHILD);
			}
		}
		baseMapper.updateById(basWarehouse);
	}
	
	@Override
	public void deleteBasWarehouse(String id) throws JeecgBootException {
		BasWarehouse basWarehouse = this.getById(id);
		if(basWarehouse==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		updateOldParentNode(basWarehouse.getPid());
		baseMapper.deleteById(id);
	}
	
	
	
	/**
	 * 根据所传pid查询旧的父级节点的子节点并修改相应状态值
	 * @param pid
	 */
	private void updateOldParentNode(String pid) {
		if(!IBasWarehouseService.ROOT_PID_VALUE.equals(pid)) {
			Integer count = baseMapper.selectCount(new QueryWrapper<BasWarehouse>().eq("pid", pid));
			if(count==null || count<=1) {
				baseMapper.updateTreeNodeStatus(pid, IBasWarehouseService.NOCHILD);
			}
		}
	}

}
