
#ifndef HCConst
#define HCConst
typedef enum {
    HCTopicTypeAll = 1,
    HCTopicTypePicture = 10,
    HCTopicTypeWord = 29,
    HCTopicTypeVoice = 31,
    HCTopicTypeVideo = 41
} HCTopicType;
/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const HCTitleViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const HCTitleViewY;
/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const HCTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const HCTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const HCTopicCellBottomBarH;
/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const HCTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const HCTopicCellPictureBreakH;
#endif