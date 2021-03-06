package com.personalWebsite.service;

import com.personalWebsite.dao.CommentRepository;
import com.personalWebsite.entity.CommentEntity;
import com.personalWebsite.model.request.comment.CommentPageForm;
import com.personalWebsite.model.request.comment.MessageForm;
import com.personalWebsite.model.response.comment.CommentUserInfo;
import com.personalWebsite.utils.DateUtil;
import com.personalWebsite.utils.IdUtil;
import com.personalWebsite.vo.CommentInfo;
import com.personalWebsite.vo.PageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.Predicate;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 评论服务类.
 * Created by xiatianlong on 2018/1/8.
 */
@Service
@Transactional(readOnly = true)
public class CommentServiceImpl extends BaseServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    /**
     * 保存评论
     *
     * @param form form
     */
    @Transactional
    @Override
    public CommentEntity saveComment(MessageForm form) {
        CommentEntity commentEntity = new CommentEntity();
        commentEntity.setCommentId(IdUtil.createId(getLoinUser().getUserId()));
        // 评论业务ID
        commentEntity.setCommentBizId(form.getCommentBizId());
        // 评论人ID
        commentEntity.setCommentUserId(getLoinUser().getUserId());
        // 评论内容
        commentEntity.setCommentContent(form.getCommentContent());
        // 评论业务类型
        commentEntity.setCommonBizType(form.getCommentBizType());

        commentEntity.setCreateUser(getLoinUser().getUserId());
        commentEntity.setUpdateUser(getLoinUser().getUserId());
        Date now = new Date();
        commentEntity.setCreateTime(now);
        commentEntity.setUpdateTime(now);

        return commentRepository.save(commentEntity);
    }

    /**
     * 分页检索留言
     *
     * @param form 请求form
     * @return 分页结果
     */
    @SuppressWarnings("unchecked")
    @Override
    public PageVO<CommentEntity> getCommentListByPage(final CommentPageForm form) {

        Sort.Order order = new Sort.Order(Sort.Direction.DESC, "commentId");

        Pageable pageable = new PageRequest(form.getPageNo() - 1, form.getPageSize(), new Sort(order));

        Specification<CommentEntity> specification = (root, query, cb) -> {
            List<Predicate> predicateList = new ArrayList<>();

            predicateList.add(cb.equal(root.get("commonBizType"), form.getCommentBizType()));
            predicateList.add(cb.equal(root.get("commentBizId"), form.getCommentBizId()));

            Predicate[] pre = new Predicate[predicateList.size()];
            return cb.and(predicateList.toArray(pre));
        };

        return new PageVO(commentRepository.findAll(specification, pageable));
    }

    /**
     * 封装评论信息
     *
     * @return 评论信息
     */
    @Override
    public List<CommentInfo> getCommentInfo(List<CommentEntity> commentEntityList) {
        if (commentEntityList != null && !commentEntityList.isEmpty()) {
            // 一级评论
            List<CommentInfo> commentInfos = new ArrayList<>();
            for (CommentEntity commentEntity : commentEntityList) {
                commentInfos.add(getCommentInfo(commentEntity));
            }
            return commentInfos;
        }
        return null;
    }

    /**
     * 封装评论信息
     *
     * @return 评论信息
     */
    @Override
    public CommentInfo getCommentInfo(CommentEntity commentEntity) {

        if (commentEntity == null) {
            return null;
        }

        CommentInfo commentInfo = new CommentInfo();
        // 评论ID
        commentInfo.setCommentId(commentEntity.getCommentId());
        // 评论用户ID
        commentInfo.setCommentUserId(commentEntity.getCommentUserId());
        // 评论用户名称
        commentInfo.setCommentUserName(commentEntity.getCommentUser().getUserName());
        // 评论用户头像
        commentInfo.setCommentUserHeadImg(commentEntity.getCommentUser().getUserHeadImg());
        // 评论内容
        commentInfo.setCommentContent(commentEntity.getCommentContent());
        // 评论时间
        commentInfo.setCommentFmtTime(DateUtil.getStrDate(commentEntity.getCreateTime()));

        return commentInfo;
    }

    /**
     * 获取热评用户
     *
     * @return 热评用户集合
     */
    @Override
    public List<CommentUserInfo> getHotCommentUser() {

        List<Object[]> dataList = commentRepository.getHotCommentUser();
        if (dataList != null && !dataList.isEmpty()) {
            List<CommentUserInfo> list = new ArrayList<>();
            for (Object[] arr : dataList) {
                CommentUserInfo info = new CommentUserInfo();
                info.setCommentUserId((String) arr[0]);
                info.setCommentCount(((BigInteger) arr[1]).longValue());
                info.setUserName((String) arr[2]);
                if (!StringUtils.isEmpty(arr[3])) {
                    info.setUserHeadImg((String) arr[3]);
                } else {
                    info.setUserHeadImg((String) arr[4]);
                }
                if (!StringUtils.isEmpty(info.getUserHeadImg())) {
                    // 做http -> https的替换
                    info.setUserHeadImg(info.getUserHeadImg().replace("http://", "https://"));
                }
                list.add(info);
            }
            return list;
        }
        return null;
    }

    /**
     * 获取评论数
     *
     * @param commentBizType 评论业务类型
     * @return long
     */
    @Override
    public long getCommentCount(String commentBizType) {

        if (StringUtils.isEmpty(commentBizType)) {
            return commentRepository.getAllCommentCnt();
        } else {
            return commentRepository.getCommentCntByBizType(commentBizType);
        }
    }


}
