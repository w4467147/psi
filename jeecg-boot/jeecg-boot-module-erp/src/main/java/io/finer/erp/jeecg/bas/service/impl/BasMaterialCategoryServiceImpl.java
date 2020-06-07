package io.finer.erp.jeecg.bas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.jeecg.common.constant.CacheConstant;
import org.jeecg.common.constant.CommonConstant;
import org.jeecg.common.exception.JeecgBootException;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.bas.entity.BasMaterialCategory;
import io.finer.erp.jeecg.bas.mapper.BasMaterialCategoryMapper;
import io.finer.erp.jeecg.bas.service.IBasMaterialCategoryService;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.List;

/**
 * @Description: 物料分类
 * @Author: jeecg-boot
 * @Date:   2020-05-29
 * @Version: V1.0
 */
@Service
public class BasMaterialCategoryServiceImpl extends ServiceImpl<BasMaterialCategoryMapper, BasMaterialCategory> implements IBasMaterialCategoryService {

	@Override
	public void addBasMaterialCategory(BasMaterialCategory basMaterialCategory) {
		if(oConvertUtils.isEmpty(basMaterialCategory.getPid())){
			basMaterialCategory.setPid(IBasMaterialCategoryService.ROOT_PID_VALUE);
		}else{
			//如果当前节点父ID不为空 则设置父节点的hasChildren 为1
			BasMaterialCategory parent = baseMapper.selectById(basMaterialCategory.getPid());
			if(parent!=null && !"1".equals(parent.getHasChild())){
				parent.setHasChild("1");
				baseMapper.updateById(parent);
			}
		}
		baseMapper.insert(basMaterialCategory);
	}
	
	@Override
	public void updateBasMaterialCategory(BasMaterialCategory basMaterialCategory) {
		BasMaterialCategory entity = this.getById(basMaterialCategory.getId());
		if(entity==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		String old_pid = entity.getPid();
		String new_pid = basMaterialCategory.getPid();
		if(!old_pid.equals(new_pid)) {
			updateOldParentNode(old_pid);
			if(oConvertUtils.isEmpty(new_pid)){
				basMaterialCategory.setPid(IBasMaterialCategoryService.ROOT_PID_VALUE);
			}
			if(!IBasMaterialCategoryService.ROOT_PID_VALUE.equals(basMaterialCategory.getPid())) {
				baseMapper.updateTreeNodeStatus(basMaterialCategory.getPid(), IBasMaterialCategoryService.HASCHILD);
			}
		}
		baseMapper.updateById(basMaterialCategory);
	}
	
	@Override
	public void deleteBasMaterialCategory(String id) throws JeecgBootException {
		BasMaterialCategory basMaterialCategory = this.getById(id);
		if(basMaterialCategory==null) {
			throw new JeecgBootException("未找到对应实体");
		}
		updateOldParentNode(basMaterialCategory.getPid());
		baseMapper.deleteById(id);
	}

	/**
	 * 根据所传pid查询旧的父级节点的子节点并修改相应状态值
	 * @param pid
	 */
	private void updateOldParentNode(String pid) {
		if(!IBasMaterialCategoryService.ROOT_PID_VALUE.equals(pid)) {
			Integer count = baseMapper.selectCount(new QueryWrapper<BasMaterialCategory>().eq("pid", pid));
			if(count==null || count<=1) {
				baseMapper.updateTreeNodeStatus(pid, IBasMaterialCategoryService.NOCHILD);
			}
		}
	}

}
